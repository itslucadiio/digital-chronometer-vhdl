<h2 align="center">Digital Dhronometer in VHDL</h2>

The aim of this project is to describe and implement a digital chronometer in the FPGA of the Basys 3 card. The main characteristics of this are described below:

- We will use the built-in 100 Mhz oscillator as the clock signal source.
- The count value will be shown on the 4 7-segment displays of the Basys III.
- There will be two possible formats to show the counting value for the displays, of which we will choose one using one of the switches on the card: MM:SS or SS:CC.
- Another push-button will have the function of LAP, with which we will be able to visualize a partial time while internally the chronometer is advancing. When this button is pressed, the display will stop until we press it again, at which point we will display the current moving time again.
- Finally, a button will allow us to view the last part-time stored. This value will be displayed on the displays as long as the pushbutton remains on.

