## Clock signal - Basys3 100 MHz clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Center Button - btnC
set_property PACKAGE_PIN U18 [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]

## LED 0 - LD0
set_property PACKAGE_PIN U16 [get_ports led0]
set_property IOSTANDARD LVCMOS33 [get_ports led0]

## LED 1 - LD1
set_property PACKAGE_PIN E19 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]

## USB-UART TX
set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]
