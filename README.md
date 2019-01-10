# PolyphonicSynthesizer
Polyphonic Synthesizer for FPGA device (BASYS3)

Project is created in VIVADO 2018.2
Can be restored in VIVADO by using XPR file

You can reach bitstream file for BASYS3 at C:\Users\Tolga YILDIZ\Desktop\Git\Polyphonic_Synthesizer\Polyphonic_Synthesizer.runs\impl_1\Top_Module.bit
You can also use this file as a memory configuration file for BASYS3

This synthesizer uses PWM to create analog waves, BASYS3 has 100 MHz clock and the frequency of PWM is 97,656 kHz(10^(8)/1024). Which means our 
PWM has data capacity of 10 bits. Our analog waves has the range of [-64, 63] which means 7 bits. Overflow occurs when more than 4 notes are
played at the same time. It has a range of C1 to B8 (32 Hz to 7902 Hz), 7-segment display works if one note is played at the moment. A VGA 
display can show which notes are playing.

If you have BASYS3
  - First switch does nothing
  - Switches 2,3,4 are assigned to determine the octave
  - Rest of the the switches are assigned to determine which notes are playing (12 notes in an octave)
  
If you have another FPGA device:
  - In VIVADO change instrument of choice
  - Change the XDC file accordingly to device and you choice of controlling
  - Generate Bitstream file for the chosen device
  - Program the device
