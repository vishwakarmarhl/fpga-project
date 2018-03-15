/*
 * Application for the bubble game
 *
 */

#include <stdio.h>			// Used for printf()
#include "xparameters.h"	// Contains hardware addresses and bit masks
#include "xil_cache.h"		// Cache Drivers
#include "xintc.h"			// Interrupt Drivers
#include "xtmrctr.h"		// Timer Drivers
#include "xtmrctr_l.h" 		// Low-level timer drivers
#include "xil_printf.h" 	// Used for xil_printf()
#include "xgpio.h" 			// LED driver, used for General purpose I/i
#include "xspi.h"
#include "xspi_l.h"
#include "lcd.h"
#include "ADXL362.h"
#include "vga_viz.h"

volatile int timerTrigger = 0;
volatile int timerCounter = 0;

volatile char rxData = 0;
volatile char mode = 0;

/**
 * Global co-ordinate values for the bubble
 */
const int BALL_RADIUS = 5;
const int BALL_X_INIT = 20, BALL_Y_INIT = 300 ;
const int BALL_DROP_DIST = 5;
const int X_MIN = 10, X_MAX = 230, Y_MIN = 10, Y_MAX = 310;
enum DIRECTION {
	TOP 	= 1,
	BOTTOM	= 2,
	RIGHT	= 3,
	LEFT	= 4,
};

/**
 * Global Stage Data variables
 *
 * (Stage Num, x1,y1,x2,y2)
 */
int STAGE_HAZARDS[6][5] = {
		// Stage: 1
		{1,20,20,30,60},
		{1,80,95,85,120},
		{1,120,180,190,190},
		{1,40,250,140,270},
		{1,200,280,220,300},
		// Stage: 2 Add more with first field as stage number

		// Final Winning Block
		{100,190,50,210,70}
};

/**
 * Global game volatile state variables
 */
int rx_prev_sign = 20, ry_prev_sign = 30 ;
int ball_x_curr = 0, ball_y_curr = 0 ;
int stage_identifier = 1, stage_reset = 0;
int shift_dist;

/**
 * Timer interrupt to handle the various timed events
 *
 * 1. Ball drop
 * 2. Stage overall time
 */
void TimerCounterHandler(void *CallBackRef, u8 TmrCtrNumber)
{
	timerTrigger = 100;
	timerCounter++;
	char str[10];
	sprintf(str, "%d S", timerCounter);
	xil_printf(str);

	if(timerCounter >= 99){//Done
		lcdPrint(str, 200, 20);
		timerCounter = 0;
	}else{
		lcdPrint(str, 200, 20);
	}
}


/**
 * Main Logic of the bubble bounce game
 *
 * Initialize the background
 * Kickstart the grand loop
 *
 */
int gamify(){
	int ret = 0 ;
	while(1){
		//Set the stage identifier
		drawHazardground(stage_identifier);
		//Call the bubble game stage flow
		ret = bubbleStageFlow(stage_identifier);
		if(ret > 0){
			for(int k=0; k<10 ; k++){
				//TODO: Delay added for delayed read
				if(ret == 10)
					lcdPrint("GAME OVER", 80, 160);
				else if (ret == 100)
					lcdPrint("WINNER!", 80, 160);
				delay_ms(200);
				lcdPrint("         ", 80, 160);
				delay_ms(10);
			}
			clrScr();
		}
	}
}

/*
 * Draw the background and hazard for a stage
 */
int drawHazardground(int stage_id){
	setColor(255,255,0);
	fillRect(190,50,210,70);
	//Blue background border width 5
	setColor(0,0,255);
	fillRect(0,0,5,320);
	fillRect(0,5,240,0);
	fillRect(235,0,240,320);
	//Set background hazards
	for(int i=0; i<5; i++){
		//STAGE_HAZARDS[i] x1,y1,x2,y2
		if(STAGE_HAZARDS[i][0] == stage_id)
			fillRect(STAGE_HAZARDS[i][1],STAGE_HAZARDS[i][2],
					 STAGE_HAZARDS[i][3],STAGE_HAZARDS[i][4]);

	}
	//Bubble starting point in game: Draw here
	drawBubble(BALL_X_INIT,BALL_Y_INIT,BALL_RADIUS);
}

/*
 * Set the background for stage
 * Run the bubble state machine for game
 */
int bubbleStageFlow(int stage_id){
	//Set Bubble Starting point
	ball_x_curr = BALL_X_INIT;
	ball_y_curr = BALL_Y_INIT;
	//Run the Stage Loop
	int ret = 0;
	for(int h=0;h<200;h++)
	for(int g=0;g<200;g++) {
		struct axisvalues rx,ry;
		//for(int i=0; i<500000 ; i++); //TODO: Delay added for delayed read
		delay_ms(50);
		rx = ADXL362_ReadXNew();
		ry = ADXL362_ReadYNew();
		ret = bubbleStateMachine(stage_id, rx, ry); // Will return fail if something is hit
		//Reset Check
		if(ret == 10 || stage_reset == 10 || ret == 100){
			//Clear and Return
			xil_printf("FINISH... %d !!",ret);
			stage_reset = 0;
			return ret;
		}
	}
	return 0;
}

/**
 * Check for crash upon movement
 */
int checkBubbleHazards(int stage_id){
	//Check the stage border
	if(ball_x_curr < X_MIN || ball_x_curr > X_MAX ||
	   ball_y_curr < Y_MIN || ball_y_curr > Y_MAX){
		xil_printf("Found Wall... !!");
		return 10;
	}
	//Check the stage hazards
	for(int i=0; i<6; i++){
		if(STAGE_HAZARDS[i][0] == stage_id){
			if(ball_x_curr >= STAGE_HAZARDS[i][1] && ball_x_curr <= STAGE_HAZARDS[i][3] &&
			   ball_y_curr >= STAGE_HAZARDS[i][2] && ball_y_curr <= STAGE_HAZARDS[i][4]){
				xil_printf("CRASH... OOPS... !!");
				return 10;
			}
		}else if(STAGE_HAZARDS[i][0] == 100){
			if(ball_x_curr >= STAGE_HAZARDS[i][1] && ball_x_curr <= STAGE_HAZARDS[i][3] &&
				ball_y_curr >= STAGE_HAZARDS[i][2] && ball_y_curr <= STAGE_HAZARDS[i][4]){
				xil_printf("WIN... !!");
				return 100;
			}
		}
	}
	return 0;
}

/**
 * Get the distance to shift from the accelerometer values
 */
int getShiftBySensitivity(struct axisvalues r){
	if (r.thousand<=150)
		shift_dist = 0;
	else if (r.thousand>150 /*&& r.thousand<500*/)
			shift_dist = 10;
//	else if (r.thousand>300 && r.thousand<400)
//		shift_dist = 15;
//	else if (r.thousand>400 && r.thousand<500)
//		shift_dist = 20;
//	else
//		shift_dist = 25;
	return shift_dist;
}

/**
 * State machine to move the bubble in the universe
 */
int bubbleStateMachine(	int stage_id,
						struct axisvalues rx,
						struct axisvalues ry){
	// Pre-check for the stage boundary/hazard conditions
	int ret_hz = checkBubbleHazards(stage_id);
	if(ret_hz == 10){
		xil_printf("Found Hazard !!");
		return 10;
	}else if(ret_hz == 100){
		xil_printf("Win !!");
		return 100;
	}
	//Based on the value of the ADXL do bounce
	//if(rx_prev_sign != rx.sign && rx.thousand > 40){ //
	//	rx_prev_sign = rx.sign;
		if(rx.sign > 0){//TOP// changed here rx to ry checking ... top n bottom
			lcdPrint("TOP", 40, 60);
			shift_dist = getShiftBySensitivity(rx);
			moveCircle(ball_x_curr,ball_y_curr,ball_x_curr,ball_y_curr-shift_dist,BALL_RADIUS);
			ball_y_curr -= shift_dist;
			xil_printf("TOP\t %c%d.%3d - (%d,%d)\n\r", (rx.sign == 0)?'+':'-',
					rx.whole, rx.thousand, ball_x_curr,ball_y_curr);
		}
		else  {//BOTTOM
			lcdPrint("BOTTOM", 40, 60);
			shift_dist = getShiftBySensitivity(rx);
			moveCircle(ball_x_curr,ball_y_curr,ball_x_curr,ball_y_curr+shift_dist,BALL_RADIUS);
			ball_y_curr += shift_dist;
			xil_printf("BOTTOM\t %c%d.%3d - (%d,%d)\n\r", (rx.sign == 0)?'+':'-',
					rx.whole, rx.thousand, ball_x_curr,ball_y_curr);
		}

	//if(ry_prev_sign != ry.sign && ry.thousand > 40){
		//ry_prev_sign = ry.sign;
		if(ry.sign > 0){//RIGHT
			lcdPrint("RIGHT", 40, 80);
			shift_dist = getShiftBySensitivity(ry);
			moveCircle(ball_x_curr,ball_y_curr,ball_x_curr+shift_dist,ball_y_curr,BALL_RADIUS);
			ball_x_curr += shift_dist;
			xil_printf("RIGHT\t %c%d.%3d - (%d,%d)\n\r", (ry.sign == 0)?'+':'-',
					ry.whole, ry.thousand, ball_x_curr,ball_y_curr);
		}
		else{//LEFT
			lcdPrint("LEFT", 40, 80);
			shift_dist = getShiftBySensitivity(ry);
			moveCircle(ball_x_curr,ball_y_curr,ball_x_curr-shift_dist,ball_y_curr,BALL_RADIUS);
			ball_x_curr -= shift_dist;
			xil_printf("LEFT\t %c%d.%3d - (%d,%d)\n\r", (ry.sign == 0)?'+':'-',
					ry.whole, ry.thousand, ball_x_curr,ball_y_curr);

		}
	return 0;
}



/*
 * Draw a colored bubble
 */
int drawBubble(int xc, int yc, int radius){
	drawCircleColor(xc,yc,radius,1,255);
}

/*
 * Draw a circle with the following parameters
 *
 * coordinate xc, yc
 * radius 'r'
 * color R,G,B,Back/White
 * intensity of color 0-255
 *
 */
int drawCircleColor(int xc, int yc, int radius, int color, int intensity){
	int i=0,j=0;
	for(i = (xc-radius); i <= (xc+radius); i++){
		for(j = (yc-radius); j <= (yc+radius); j++){
			if(((i-xc)*(i-xc) + (j-yc)*(j-yc)) <= radius*radius){
				if(color == 1) 	   // Red
					setColor(intensity,0,0);
				else if(color == 2) //Green
					setColor(0,intensity,0);
				else if(color == 3) //Blue
					setColor(0,0,intensity);
				else if(color == 0)  //Black
					setColor(0,0,0);
				else if(color >= 10) //White
					setColor(intensity,intensity,intensity);
				//Color the bubble
				fillRect(i,j,i+2,j+2);
			}
		}
	}
}

/*
 * Move circle from centre to a target coordinate
 * X(Start) -> X(Middle) -> X(Final)
 */
int moveCircle(int xc, int yc, int xt, int yt, int radius){
	// Erase the circle
	drawCircleColor(xc,yc,radius,0,255);
	// Draw the middle step
	drawCircleColor((xc+xt)/2,(yc+yt)/2,radius,1,255);
	drawCircleColor((xc+xt)/2,(yc+yt)/2,radius,0,255);
	// Draw the final step
	drawCircleColor(xt,yt,radius,1,255);
	//Draw ball on VGA output
	drawBall(xt,yt);
}

/******
 *
 * Main entry point of the code
 *
 */
int main()
{
	static XIntc intc;
	static XTmrCtr axiTimer;
	static XGpio dc;
	static XSpi spi;

	XSpi_Config *spiConfig;	/* Pointer to Configuration data */

	u32 status;
	u32 controlReg;

	int sec = 0;
	int secTmp;
	char secStr[4];

	Xil_ICacheEnable();
	Xil_DCacheEnable();
	print("---Entering main (CK)---\n\r");

	status = XTmrCtr_Initialize(&axiTimer, XPAR_AXI_TIMER_0_DEVICE_ID);
	if (status != XST_SUCCESS) {
		xil_printf("Initialize timer fail!\n");
		return XST_FAILURE;
	}

	status = XIntc_Initialize(&intc, XPAR_INTC_0_DEVICE_ID);
	if (status != XST_SUCCESS) {
		xil_printf("Initialize interrupt controller fail!\n");
		return XST_FAILURE;
	}

	status = XIntc_Connect(&intc,
				XPAR_MICROBLAZE_0_AXI_INTC_AXI_TIMER_0_INTERRUPT_INTR,
				(XInterruptHandler)XTmrCtr_InterruptHandler,
				(void *)&axiTimer);
	if (status != XST_SUCCESS) {
		xil_printf("Connect IHR fail!\n");
		return XST_FAILURE;
	}

	status = XIntc_Start(&intc, XIN_REAL_MODE);
	if (status != XST_SUCCESS) {
		xil_printf("Start interrupt controller fail!\n");
		return XST_FAILURE;
	}

	// Enable interrupt
	XIntc_Enable(&intc, XPAR_MICROBLAZE_0_AXI_INTC_AXI_TIMER_0_INTERRUPT_INTR);
	microblaze_enable_interrupts();

	/*
	 * Setup the handler for the timer counter that will be called from the
	 * interrupt context when the timer expires, specify a pointer to the
	 * timer counter driver instance as the callback reference so the handler
	 * is able to access the instance data
	 */
	XTmrCtr_SetHandler(&axiTimer, TimerCounterHandler, &axiTimer);

	/*
	 * Enable the interrupt of the timer counter so interrupts will occur
	 * and use auto reload mode such that the timer counter will reload
	 * itself automatically and continue repeatedly, without this option
	 * it would expire once only
	 */
	XTmrCtr_SetOptions(&axiTimer, 0,
				XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION);

	/*
	 * Set a reset value for the timer counter such that it will expire
	 * eariler than letting it roll over from 0, the reset value is loaded
	 * into the timer counter when it is started
	 */
	XTmrCtr_SetResetValue(&axiTimer, 0, 0x26250); //0xFFFF0000
	//#define RESET_VALUE                    0xF4240
	// 0x2625A0 //0x7A120 //0x4C4B40 //0x5D3E //0x861C4680 //0xC00 //0x10000

	/*
	 * Start the timer counter such that it's incrementing by default,
	 * then wait for it to timeout a number of times
	 */
	XTmrCtr_Start(&axiTimer, 0);
	xil_printf("Timer start!\n");
	/*
	 * Initialize the GPIO driver so that it's ready to use,
	 * specify the device ID that is generated in xparameters.h
	 */
	status = XGpio_Initialize(&dc, XPAR_SPI_DC_DEVICE_ID);
	if (status != XST_SUCCESS)  {
		xil_printf("Initialize GPIO dc fail!\n");
		return XST_FAILURE;
	}
	/*
	 * Set the direction for all signals to be outputs
	 */
	XGpio_SetDataDirection(&dc, 1, 0x0);
	/*
	 * Initialize the SPI driver so that it is  ready to use.
	 */
	spiConfig = XSpi_LookupConfig(XPAR_SPI_DEVICE_ID);
	if (spiConfig == NULL) {
		xil_printf("Can't find spi device!\n");
		return XST_DEVICE_NOT_FOUND;
	}
	status = XSpi_CfgInitialize(&spi, spiConfig, spiConfig->BaseAddress);
	if (status != XST_SUCCESS) {
		xil_printf("Initialize spi fail!\n");
		return XST_FAILURE;
	}
	/*
	 * Reset the SPI device to leave it in a known good state.
	 */
	XSpi_Reset(&spi);
	/*
	 * Setup the control register to enable master mode
	 */
	controlReg = XSpi_GetControlReg(&spi);
	XSpi_SetControlReg(&spi,
			(controlReg | XSP_CR_ENABLE_MASK | XSP_CR_MASTER_MODE_MASK) &
			(~XSP_CR_TRANS_INHIBIT_MASK));

	// Select 1st slave device
	XSpi_SetSlaveSelectReg(&spi, ~0x01);
	SPI_Init(SPI_BASEADDR, 0, 0, 0);

	ADXL362_WriteReg(ADXL362_SOFT_RESET, ADXL362_RESET_CMD);
	delay_ms(10);
	ADXL362_WriteReg(ADXL362_SOFT_RESET, 0x00);
	// Enable Measurement
	ADXL362_WriteReg(ADXL362_POWER_CTL, (2 << ADXL362_MEASURE));
	initLCD();
	clrScr();

	//VGA Init Test code
	displayInit();

	// Initialize the game logic
	gamify();

	xil_printf("End\n");
	return 0;
}
