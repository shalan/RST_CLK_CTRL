###############################################################################
# Created by write_sdc
# Tue Apr 25 10:55:41 2023
###############################################################################
current_design por_rosc
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name __VIRTUAL_CLK__ -period 10.00
set_input_delay 0.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {fb_in}]
set_output_delay 0.0000 -clock [get_clocks {__VIRTUAL_CLK__}] -add_delay [get_ports {fb_out}]

set_false_path -from [get_ports {one}]
set_false_path -from [get_ports {zero}]

create_clock -name CLK -period 5 [get_pins {ROSC_CLKBUF_1/X}]
#[get_ports fb_out]
set_clock_uncertainty 0.100 CLK 

set_propagated_clock [all_clocks]

###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.020 [get_ports {clk_out}]
set_load -pin_load 0.0200 [get_ports {por_n}]
set_load -pin_load 0.020 [get_ports {clk_8mhz}]

###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]