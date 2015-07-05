# Using RS232 on Spartan 6 FPGA Papilio-type dev boards

rs232_rx_demo is based on the [Gadget Factory](http://www.gadgetfactory.net/) tutorial ["The quickest way to implement PC-to-FPGA communication using a Papilio FPGA board"](http://gadgetfactory.net/learn/2013/12/02/the-quickest-way-to-implement-pc-to-fpga-communication-using-a-papilio-fpga-board/). It's revised and tested against the Papilio Pro using the LogicStart board

  - On a typical installation you'll have two serial ports, one you program the board with and the other that's for the other port on the FT2232 USB chip. This program reads data from that second serial port (at 9600 baud) and displays it on the LEDs of the LogicStart board (or other LEDs if you configure it differently).

  - Note on PuTTY: Terminal -> Local line editing ought to be set to "Off" (Auto may work as well). Otherwise most of what you'll see is the CR/LF you send after whatever you type!

