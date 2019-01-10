# PolyphonicSynthesizer
Polyphonic Synthesizer for FPGA device (BASYS3)

Project is created in VIVADO 2018.2
Can be restored in VIVADO by using XPR file

You can reach bitstream file for BASYS3 at C:\Users\Tolga YILDIZ\Desktop\Git\Polyphonic_Synthesizer\Polyphonic_Synthesizer.runs\impl_1\Top_Module.bit
You can also use this file as a memory configuration file for BASYS3

This synthesizer uses PWM to create analog waves, BASYS3 has 100 MHz clock and the frequency of PWM is 97,656 kHz(10^(8)/1024). Which means our PWM has data capacity of 10 bits. Our analog waves has the range of [-64, 63] which means 7 bits. Overflow occurs when more than 4 notes are played at the same time. It has a range of C1 to B8 (32 Hz to 7902 Hz), 7-segment display works if one note is played at the moment. A VGA display can show which notes are playing. 5 modes are included. 

I tried to replicate musical instruments but did not happen as i wished. Maybe you can create them, waveforms of the instrument are in waveform folder, maybe the waveforms are wrong. Don't limit yourself with your FPGA inputs, you can use external controlling devices through pins. Modify XDC file and add some physical input devices.

From proposal - advanced you may get an idea, using a wireless bluetooth module which transmits the data from gyro module to FPGA to determine which note should play at the moment. But this works only for monophonic system. If you want to see a similar functioning device check out The Glide (https://www.youtube.com/channel/UCyT01UxHoUvvgwIsGVUG8pw) a new musical instrument, i believe it can be implemented on an FPGA but a little bit harder though.

If you have BASYS3
  - You can directly use bitstream file above to program device
  - First switch does nothing
  - Switches 2,3,4 are assigned to determine the octave
  - Rest of the the switches are assigned to determine which notes are playing (12 notes in an octave, from C to B)
  - You can change the mode of the sound by using 5 buttons. I dont't remember the oreder but it had sine, triangle, sawtooth, saxophone, clarinet. Last two modes are experimental. Didn't work out because the physical surroundings didn't meet even the waveform of the sound is the same.
  - You need an amplified output device which is connected between N1 pin and ground
  
If you have another FPGA device:
  - In VIVADO change instrument of choice
  - Change the XDC file accordingly to device and your choice of controlling
  - Generate Bitstream file for the chosen device
  - Program the device
  - You still need an amplified output device which is connected between output pin you've decided and ground
  
If you don't have any FPGA device:
  - Well, sorry. Have nice day.
