The Very Simplest Icestorm+8k Breakout Board Example
====

This a simple example to cover all the steps needed to blink an LED on the iCE40-HX8K Breakout Board, a low-cost development board for the largest chip in the iCE40 series supported by the IceStorm project by Clifford Wolf et al.

You need the following tools:

* yosys, for verilog synthesis ("compilation" to netlist, basic logic elements)
* arachne-pnr, for place-and-route (mapping the netlist to specific FPGA resources)
* icestorm (to create bitstreams and programme the FPGA on the board)

There are four files here:

# blink.v

The actual Verilog code, a simple top-level module with a clock input and output to drive one of the on-board LEDs.

# blink.pcf

This is a "constraints file" which maps wires in the top level to physical pins/pads on the FPGA. This is the part that is different compared to the iCEStick examples. The PCF file uses the names of the physical pads, so you can get them from the datasheet, or more conveniently the schematic for the board you're using, since this will also show where they're connected. 

The names are different on the BGA-packaged 8K compared to the LQFP-packaged 1K, since the balls on BGA packages are named according to a grid system, whereas the QFP package has sequentially numbered pins.

If you want to use more LEDs or pins on the expansion headers, you'll need to name them in this file. The syntax should be self-explanatory.

# build.yosys

This is just a file that contains the two Yosys commands required to turn the verilog into a netlist, which can then be placed-and-routed by Arachne.

This is separate from the makefile to be more flexible, but the commands could easily be added inline to the makefile that actually calls the yosys command.

# Makefile

A makefile that runs the three commands necessary to build a file that can be use to configure the FPGA. First the Verilog is converted to a netlist using Yosys; then Arachne is use to place-and-route the design for the specific FPGA (the HX8K0); then the configuration file is converted to a bitstream, which can be used to programme the FPGA using the tool iceprog. For your convenience, targets to flash and clean build artifacts are also provided.

That is, to blink an LED, install tools so they're in your path, then run "make flash".

Note that we are leaving most of the LEDs unconnected and in a default state, which seems to be "on but dim". One of the LEDs should blink.
