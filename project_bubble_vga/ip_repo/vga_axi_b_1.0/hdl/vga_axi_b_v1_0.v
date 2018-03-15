
`timescale 1 ns / 1 ps

	module vga_axi_b_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_VGA_AXI
		parameter integer C_S00_VGA_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_VGA_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here
        /** TODO: Add the VGA related RGB, and register values **/
        output wire hsync,
        output wire vsync,
        output wire [3:0] red,
        output wire [3:0] blue,
        output wire [3:0] green,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_VGA_AXI
		input wire  s00_vga_axi_aclk,
		input wire  s00_vga_axi_aresetn,
		input wire [C_S00_VGA_AXI_ADDR_WIDTH-1 : 0] s00_vga_axi_awaddr,
		input wire [2 : 0] s00_vga_axi_awprot,
		input wire  s00_vga_axi_awvalid,
		output wire  s00_vga_axi_awready,
		input wire [C_S00_VGA_AXI_DATA_WIDTH-1 : 0] s00_vga_axi_wdata,
		input wire [(C_S00_VGA_AXI_DATA_WIDTH/8)-1 : 0] s00_vga_axi_wstrb,
		input wire  s00_vga_axi_wvalid,
		output wire  s00_vga_axi_wready,
		output wire [1 : 0] s00_vga_axi_bresp,
		output wire  s00_vga_axi_bvalid,
		input wire  s00_vga_axi_bready,
		input wire [C_S00_VGA_AXI_ADDR_WIDTH-1 : 0] s00_vga_axi_araddr,
		input wire [2 : 0] s00_vga_axi_arprot,
		input wire  s00_vga_axi_arvalid,
		output wire  s00_vga_axi_arready,
		output wire [C_S00_VGA_AXI_DATA_WIDTH-1 : 0] s00_vga_axi_rdata,
		output wire [1 : 0] s00_vga_axi_rresp,
		output wire  s00_vga_axi_rvalid,
		input wire  s00_vga_axi_rready
	);
// Instantiation of Axi Bus Interface S00_VGA_AXI
	vga_axi_b_v1_0_S00_VGA_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_VGA_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_VGA_AXI_ADDR_WIDTH)
	) vga_axi_b_v1_0_S00_VGA_AXI_inst (
		.S_AXI_ACLK(s00_vga_axi_aclk),
		.S_AXI_ARESETN(s00_vga_axi_aresetn),
		.S_AXI_AWADDR(s00_vga_axi_awaddr),
		.S_AXI_AWPROT(s00_vga_axi_awprot),
		.S_AXI_AWVALID(s00_vga_axi_awvalid),
		.S_AXI_AWREADY(s00_vga_axi_awready),
		.S_AXI_WDATA(s00_vga_axi_wdata),
		.S_AXI_WSTRB(s00_vga_axi_wstrb),
		.S_AXI_WVALID(s00_vga_axi_wvalid),
		.S_AXI_WREADY(s00_vga_axi_wready),
		.S_AXI_BRESP(s00_vga_axi_bresp),
		.S_AXI_BVALID(s00_vga_axi_bvalid),
		.S_AXI_BREADY(s00_vga_axi_bready),
		.S_AXI_ARADDR(s00_vga_axi_araddr),
		.S_AXI_ARPROT(s00_vga_axi_arprot),
		.S_AXI_ARVALID(s00_vga_axi_arvalid),
		.S_AXI_ARREADY(s00_vga_axi_arready),
		.S_AXI_RDATA(s00_vga_axi_rdata),
		.S_AXI_RRESP(s00_vga_axi_rresp),
		.S_AXI_RVALID(s00_vga_axi_rvalid),
		.S_AXI_RREADY(s00_vga_axi_rready),
		
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
	);

	// Add user logic here

	// User logic ends

	endmodule
