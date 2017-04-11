===Description===
This is a sample app that uses RGB LED and buzzer. RGB LED serves as a state indicator. Buzzer is used for making countdown beeping sound indicating that time ends.

Agent API handles colour change request with "red" and "green" options; beeping trigger request that takes beep count as an argument.

Device will show green light when started.

===Files===
light-and-beeping.device.nut - device code
light-and-beeping.agent.nut - device server (agent) code
light-and-beeping-schematic.fzz - schematic made with Fritzing app (http://fritzing.org/download)
light-and-beeping-schematic-bb.png - schematic image

electric_imp_april_breakout.fzpz - Electirc IMP custom module required by schematic 
(module taken from here - https://forums.electricimp.com/discussion/601/fritzing-parts)