This file maps the Verilog port names to physical pins on the Cmod A7-35T
12 MHz Clock
set_property -dict { PACKAGE_PIN L17 IOSTANDARD LVCMOS33 } [get_ports { sysclk }];
create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports { sysclk }];
Buttons (CHANGED TO PULLUP for Active Low)
Wiring: Connect Button to Pin X and GND (Blue Rail)
set_property -dict { PACKAGE_PIN M3 IOSTANDARD LVCMOS33 PULLUP true } [get_ports { btn1 }]; # Pin 1
set_property -dict { PACKAGE_PIN L3 IOSTANDARD LVCMOS33 PULLUP true } [get_ports { btn2 }]; # Pin 2
Launch LED
set_property -dict { PACKAGE_PIN A16 IOSTANDARD LVCMOS33 } [get_ports { led_launch }]; # Pin 3
7-Segment Display Segments (a-g)
set_property -dict { PACKAGE_PIN K3 IOSTANDARD LVCMOS33 } [get_ports { seg[0] }]; # Pin 4 (Seg A)
set_property -dict { PACKAGE_PIN C15 IOSTANDARD LVCMOS33 } [get_ports { seg[1] }]; # Pin 5 (Seg B)
set_property -dict { PACKAGE_PIN H1 IOSTANDARD LVCMOS33 } [get_ports { seg[2] }]; # Pin 6 (Seg C)
set_property -dict { PACKAGE_PIN A15 IOSTANDARD LVCMOS33 } [get_ports { seg[3] }]; # Pin 7 (Seg D)
set_property -dict { PACKAGE_PIN B15 IOSTANDARD LVCMOS33 } [get_ports { seg[4] }]; # Pin 8 (Seg E)
set_property -dict { PACKAGE_PIN A14 IOSTANDARD LVCMOS33 } [get_ports { seg[5] }]; # Pin 9 (Seg F)
set_property -dict { PACKAGE_PIN J3 IOSTANDARD LVCMOS33 } [get_ports { seg[6] }]; # Pin 10 (Seg G)
