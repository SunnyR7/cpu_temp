
s
Command: %s
53*	vivadotcl2B
.link_design -top cputop -part xc7a100tfgg484-12default:defaultZ4-113h px? 
g
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_12default:defaultZ12-437h px? 
j
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_12default:defaultZ12-434h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2Q
=d:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/cpuclk/cpuclk.dcp2default:default2
	cpu_clock2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2M
9d:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/uart/uart.dcp2default:default2
uart2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2K
7d:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/RAM/RAM.dcp2default:default2
dmemory/ram2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2Q
=d:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/prgrom/prgrom.dcp2default:default2"
ifetch/instmem2default:defaultZ1-454h px? 
h
-Analyzing %s Unisim elements for replacement
17*netlist2
10992default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2017.42default:defaultZ1-479h px? 
W
Loading part %s157*device2$
xc7a100tfgg484-12default:defaultZ21-403h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
?
NRemoving redundant IBUF since it is not being driven by a top-level port. %s 
32*opt2:
&uart/inst/upg_inst/upg_clk_i_IBUF_inst2default:defaultZ31-32h px? 
?
NRemoving redundant IBUF since it is not being driven by a top-level port. %s 
32*opt2:
&uart/inst/upg_inst/upg_rst_i_IBUF_inst2default:defaultZ31-32h px? 
?
LRemoving redundant IBUF, %s, from the path connected to top-level port: %s 
35*opt29
%uart/inst/upg_inst/upg_rx_i_IBUF_inst2default:default2
rx2default:defaultZ31-35h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[0]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_adr_o_OBUF[10]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_adr_o_OBUF[11]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_adr_o_OBUF[12]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_adr_o_OBUF[13]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_adr_o_OBUF[14]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[1]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[2]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[3]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[4]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[5]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[6]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[7]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[8]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_adr_o_OBUF[9]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2:
&uart/inst/upg_inst/upg_clk_o_OBUF_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[0]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[10]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[11]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[12]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[13]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[14]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[15]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[16]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[17]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[18]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[19]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[1]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[20]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[21]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[22]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[23]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[24]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[25]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[26]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[27]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[28]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[29]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[2]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[30]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2>
*uart/inst/upg_inst/upg_dat_o_OBUF[31]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[3]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[4]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[5]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[6]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[7]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[8]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2=
)uart/inst/upg_inst/upg_dat_o_OBUF[9]_inst2default:defaultZ31-33h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2;
'uart/inst/upg_inst/upg_done_o_OBUF_inst2default:defaultZ31-33h px? 
?
LRemoving redundant OBUF, %s, from the path connected to top-level port: %s 
36*opt2 
tx_OBUF_inst2default:default2
tx2default:defaultZ31-36h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2:
&uart/inst/upg_inst/upg_wen_o_OBUF_inst2default:defaultZ31-33h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2Y
Cd:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/cpuclk/cpuclk_board.xdc2default:default2$
cpu_clock/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2Y
Cd:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/cpuclk/cpuclk_board.xdc2default:default2$
cpu_clock/inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2S
=d:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/cpuclk/cpuclk.xdc2default:default2$
cpu_clock/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2S
=d:/VivadoProCS202/CPU/CPU.srcs/sources_1/ip/cpuclk/cpuclk.xdc2default:default2$
cpu_clock/inst	2default:default8Z20-847h px? 
?
Parsing XDC File [%s]
179*designutils2M
7D:/VivadoProCS202/CPU/CPU.srcs/constrs_1/new/cputop.xdc2default:default8Z20-179h px? 
?
Finished Parsing XDC File [%s]
178*designutils2M
7D:/VivadoProCS202/CPU/CPU.srcs/constrs_1/new/cputop.xdc2default:default8Z20-178h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
112default:default2
542default:default2
02default:default2
02default:defaultZ4-41h px? 
]
%s completed successfully
29*	vivadotcl2
link_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2!
link_design: 2default:default2
00:00:122default:default2
00:00:142default:default2
596.1952default:default2
364.7812default:defaultZ17-268h px? 
~
4The following parameters have non-default value.
%s
395*common2&
general.maxThreads2default:defaultZ17-600h px? 


End Record