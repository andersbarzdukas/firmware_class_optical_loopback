#Clocks
set_property -dict { PACKAGE_PIN G10  IOSTANDARD LVDS} [get_ports clk_in_p]
set_property -dict { PACKAGE_PIN F10  IOSTANDARD LVDS} [get_ports clk_in_n]

#KCU105 LEDs
set_property -dict { PACKAGE_PIN AP8 IOSTANDARD LVCMOS18} [get_ports led_out[0]]
set_property -dict { PACKAGE_PIN H23 IOSTANDARD LVCMOS18} [get_ports led_out[1]]
set_property -dict { PACKAGE_PIN P20 IOSTANDARD LVCMOS18} [get_ports led_out[2]]
set_property -dict { PACKAGE_PIN P21 IOSTANDARD LVCMOS18} [get_ports led_out[3]]
set_property -dict { PACKAGE_PIN N22 IOSTANDARD LVCMOS18} [get_ports led_out[4]]
set_property -dict { PACKAGE_PIN M22 IOSTANDARD LVCMOS18} [get_ports led_out[5]]
set_property -dict { PACKAGE_PIN R23 IOSTANDARD LVCMOS18} [get_ports led_out[6]]
set_property -dict { PACKAGE_PIN P23 IOSTANDARD LVCMOS18} [get_ports led_out[7]]

#Optical link TX and RX
#set_property -dict { PACKAGE_PIN ? IOSTANDARD ?} [get_ports ?]
#set_property -dict { PACKAGE_PIN ? IOSTANDARD ?} [get_ports ?]

#Optical link clock
#set_property -dict { PACKAGE_PIN ? IOSTANDARD ?} [get_ports ?]