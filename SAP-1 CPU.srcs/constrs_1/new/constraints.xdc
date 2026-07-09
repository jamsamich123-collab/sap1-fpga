set_property PACKAGE_PIN W5 [get_ports clk100]
set_property IOSTANDARD LVCMOS33 [get_ports clk100]
create_clock -period 10.000 -name sys_clk [get_ports clk100]

# Center button = reset
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# User button (BTNU) = step clock
set_property PACKAGE_PIN T18 [get_ports btn_step]
set_property IOSTANDARD LVCMOS33 [get_ports btn_step]

# mode switch (SW0)
set_property PACKAGE_PIN V17 [get_ports mode]
set_property IOSTANDARD LVCMOS33 [get_ports mode]

# 7-SEG DISPLAY (ANODES)

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]

set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]

set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]

set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

 # 7-SEG DISPLAY (CATHODES)

set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

# W_bus display
set_property PACKAGE_PIN V13 [get_ports {bus_value[0]}]
set_property PACKAGE_PIN V3  [get_ports {bus_value[1]}]
set_property PACKAGE_PIN W3  [get_ports {bus_value[2]}]
set_property PACKAGE_PIN U3  [get_ports {bus_value[3]}]
set_property PACKAGE_PIN P3  [get_ports {bus_value[4]}]
set_property PACKAGE_PIN N3  [get_ports {bus_value[5]}]
set_property PACKAGE_PIN P1  [get_ports {bus_value[6]}]
set_property PACKAGE_PIN L1  [get_ports {bus_value[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {bus_value[7]}]