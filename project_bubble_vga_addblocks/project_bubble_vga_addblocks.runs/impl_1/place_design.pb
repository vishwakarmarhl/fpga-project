
�
�No debug cores found in the current design.
Before running the implement_debug_core command, either use the Set Up Debug wizard (GUI mode)
or use the create_debug_core and connect_debug_core Tcl commands to insert debug cores into the design.
154*	chipscopeZ16-241h px� 
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2#
xc7a100t-csg3242default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2#
xc7a100t-csg3242default:defaultZ17-349h px� 
y
Command: %s
53*	vivadotcl2H
4report_drc (run_mandatory_drcs) for: incr_eco_checks2default:defaultZ4-113h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
q
%s completed successfully
29*	vivadotcl23
report_drc (run_mandatory_drcs)2default:defaultZ4-42h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
w
Command: %s
53*	vivadotcl2F
2report_drc (run_mandatory_drcs) for: placer_checks2default:defaultZ4-113h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
q
%s completed successfully
29*	vivadotcl23
report_drc (run_mandatory_drcs)2default:defaultZ4-42h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.1452default:default2
1866.9382default:default2
0.0002default:defaultZ17-268h px� 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 865c41a9
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.166 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0952default:default2
1866.9382default:default2
0.0002default:defaultZ17-268h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 461f0433
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:13 ; elapsed = 00:00:11 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
O
:Phase 1.3 Build Placer Netlist Model | Checksum: c28da0f4
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:23 ; elapsed = 00:00:19 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
L
7Phase 1.4 Constrain Clocks/Macros | Checksum: c28da0f4
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:23 ; elapsed = 00:00:19 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
H
3Phase 1 Placer Initialization | Checksum: c28da0f4
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:23 ; elapsed = 00:00:19 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
C
.Phase 2 Global Placement | Checksum: d33ce5d1
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:04 ; elapsed = 00:00:40 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
O
:Phase 3.1 Commit Multi Column Macros | Checksum: d33ce5d1
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:04 ; elapsed = 00:00:40 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1a3ac2bbb
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:11 ; elapsed = 00:00:45 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 185a1619c
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:11 ; elapsed = 00:00:45 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 242d26d71
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:11 ; elapsed = 00:00:45 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
x

Phase %s%s
101*constraints2
3.5 2default:default2)
Timing Path Optimizer2default:defaultZ18-101h px� 
K
6Phase 3.5 Timing Path Optimizer | Checksum: 1b70eb865
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:13 ; elapsed = 00:00:46 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.6 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.6 Small Shape Detail Placement | Checksum: 175cbe34d
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:23 ; elapsed = 00:00:56 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
u

Phase %s%s
101*constraints2
3.7 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.7 Re-assign LUT pins | Checksum: 11a2c1d81
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:24 ; elapsed = 00:00:57 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.8 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.8 Pipeline Register Optimization | Checksum: 11a2c1d81
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:24 ; elapsed = 00:00:57 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 11a2c1d81
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:25 ; elapsed = 00:00:57 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 1131340a8
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
22default:defaultZ32-721h px� 
�
PProcessed net %s, BUFG insertion was skipped due to placement/routing conflicts.33*	placeflow2?
+system_i/vga_axi_0/inst/axi_awready_i_1_n_02default:defaultZ46-38h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason.36*	placeflow2
12default:default2
02default:default2
12default:default2
02default:default2
02default:defaultZ46-41h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 1131340a8
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:37 ; elapsed = 00:01:06 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
0.5332default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 1aca8c2f6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:38 ; elapsed = 00:01:07 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 1aca8c2f6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:39 ; elapsed = 00:01:08 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 1aca8c2f6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:39 ; elapsed = 00:01:08 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 1aca8c2f6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:39 ; elapsed = 00:01:08 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 198c7bcf2
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:40 ; elapsed = 00:01:08 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 198c7bcf2
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:40 ; elapsed = 00:01:09 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
>
)Ending Placer Task | Checksum: 121cafa34
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:40 ; elapsed = 00:01:09 . Memory (MB): peak = 1866.938 ; gain = 0.0002default:defaulth px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
782default:default2
72default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
place_design: 2default:default2
00:01:452default:default2
00:01:122default:default2
1866.9382default:default2
0.0002default:defaultZ17-268h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:082default:default2
00:00:032default:default2
1866.9382default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2�
�C:/Users/Karma/Documents/workspace/final_project/project_bubble_vga_addblocks/project_bubble_vga_addblocks.runs/impl_1/system_wrapper_placed.dcp2default:defaultZ17-1381h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:152default:default2
00:00:072default:default2
1866.9382default:default2
0.0002default:defaultZ17-268h px� 
�
kreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.111 . Memory (MB): peak = 1866.938 ; gain = 0.000
*commonh px� 
�
treport_utilization: Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.315 . Memory (MB): peak = 1866.938 ; gain = 0.000
*commonh px� 
�
ureport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.122 . Memory (MB): peak = 1866.938 ; gain = 0.000
*commonh px� 


End Record