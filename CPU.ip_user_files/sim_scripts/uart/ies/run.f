-makelib ies_lib/xil_defaultlib -sv \
  "D:/software/vivado/download/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/software/vivado/download/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/software/vivado/download/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../CPU.srcs/sources_1/ip/uart/uart_bmpg.v" \
  "../../../../CPU.srcs/sources_1/ip/uart/upg.v" \
  "../../../../CPU.srcs/sources_1/ip/uart/sim/uart.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

