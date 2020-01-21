# Polyphonic_FPGA_Synthesizer
Polyphonic Synthesizer for FPGA device (BASYS3)

Project is created in VIVADO 2018.2
Can be restored in VIVADO by using XPR file

You can reach bitstream file for BASYS3 at Polyphonic_Synthesizer.runs\impl_1\Top_Module.bit
You can also use this file as a memory configuration file for BASYS3

You can read the report in the "proposals and reports" folder. You can also watch this little introduction, which includes a brief explanation and a demonstration, video for the project: https://www.youtube.com/watch?v=5W7BYjQx-zw

This synthesizer uses PWM to create analog waves, BASYS3 has 100 MHz clock and the frequency of PWM is 97,656 kHz(10^(8)/1024). Which means our PWM has data capacity of 10 bits. Our analog waves has the range of [-64, 63] which means 7 bits. Overflow occurs when more than 4 notes are played at the same time. It has a range of C1 to B8 (32 Hz to 7902 Hz), 7-segment display shows the note if one note is played at the moment, it also shows which octave you are in. A VGA display can show which notes are playing by constructing a piano on the screen with resolution of 1280x1024 and refresh rate of 60Hz, to change the resolution features you must edit the constants(porches etc) at vga_synch and vga_draw modules. You can reach the these constants at https://www.digikey.com/eewiki/pages/viewpage.action?pageId=15925278 . 

5 sound modes are included. Sine, sawtooth, triangle, saxophone,  violin. Last two are experimental, i tried to replicate musical instruments but did not happen as i wished. Maybe you can create them, waveforms of the instrument are in waveform folder, maybe the waveforms are wrong. Don't limit yourself with your FPGA inputs, you can use external controlling devices through pins. Modify XDC file and add some physical input devices.

From proposal - advanced you may get an idea, using a wireless bluetooth module which transmits the data from gyro module to FPGA to determine which note should play at the moment. But this works only for monophonic system. If you want to see a similar functioning device, check out The Glide (https://www.youtube.com/channel/UCyT01UxHoUvvgwIsGVUG8pw) a new musical instrument, i believe it can be implemented on an FPGA but a little bit harder though.

If you have BASYS3
  - You can directly use bitstream file above to program device
  - First switch does nothing
  - Switches 2,3,4 are assigned to determine the octave
  - Rest of the the switches are assigned to determine which notes are playing (12 notes in an octave, from C to B)
  - You can change the mode of the sound by using 5 buttons. I dont't remember the order but modes are sine, triangle, sawtooth, saxophone, volin. Last two modes are experimental. Didn't work out because the physical surroundings didn't meet even the waveform of the sound is the same.
  - You need an output device, system can work with a simple earphone, you don't need an aplification device.
  
If you have another FPGA device:
  - In VIVADO change instrument of choice
  - Change the XDC file accordingly to device and your choice of controlling
  - Generate Bitstream file for the chosen device
  - Program the device
  - You still need an audio output device
  
If you don't have any FPGA device:
  - Well, sorry. Have nice day. You can implement this design in other devices as well.
  
For further reading about audio synthesis and effects: https://pdfs.semanticscholar.org/f90b/fdf17612af1d77208f7b3514d2843ec0a82f.pdf
