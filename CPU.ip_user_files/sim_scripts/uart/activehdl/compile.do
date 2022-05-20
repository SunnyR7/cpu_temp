vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 \
"D:/software/vivado/download/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/software/vivado/download/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/software/vivado/download/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../CPU.srcs/sources_1/ip/uart/uart_bmpg.v" \
"../../../../CPU.srcs/sources_1/ip/uart/upg.v" \
"../../../../CPU.srcs/sources_1/ip/uart/sim/uart.v" \

vlog -work xil_defaultlib \
"glbl.v"
