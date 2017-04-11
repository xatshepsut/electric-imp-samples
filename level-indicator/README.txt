===Description===

This eIMP project animates “load levels” from 0 to 8 by turning on rows on the LED matrix. Schematic uses 1088BS LED matrix together with 74HC595N shift out controller to minimise number of pins used on the eIMP.


74HC595N shift out controller has 1 data input pin to simultaneously write data into 8 bit register. Clock pin is used to shift the data, latch pin transfers register data to 8 output pins.

1088BS LED matrix pins controlling rows and columns are mixed, wires going out of the pins in the schematic are named to indicate which one is which. Row controlling pins are common anods and columns are common cathodes. Since within this example only rows are needed, all column pins are grounded.


===Files===
level-indicator.device.nut - device code
level-indicator.agent.nut - agent code
level-indicator.fzz - schematic made with Fritzing app (http://fritzing.org/download)
level-indicator-bb.png - schematic image


Note: Real schematic looks nicer than the one in fzz file and uses less breadboards.