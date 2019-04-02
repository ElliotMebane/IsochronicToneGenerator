# IsochronicToneGenerator
Plugin for Isochronic Tone Generation in Audacity  
  
These are modified versions of the Isochronic Modulator Audacity plugin originally written by Steve Daulton.   
(https://wiki.audacityteam.org/wiki/Nyquist_Effect_Plug-ins#Isochronic_modulator)  
  
*IsomodExtended.ny*  
Initial Modulation Frequency and Final Modulation Frequency increased to 150 to allow gamma frequencies.  
  
*IsomodInOut.ny*  
Allows separate Fade-in and Fade-out settings instead of just one time setting used for both in the original plugin.  
  
*IsomodEnvelope.ny*  
Allows traditional envelope settings (attack, decay, sustain, release)  
  
![Screenshot](AudacityScreenshot.jpg?raw=true "Sample Waveforms")  

The included audio sample is 4 sequenced samples that match the samples represented in the Audacity screenshot:  
* 440Hz for 5 seconds.
* IsomodExtended for 5 seconds. Equal fade-in and fade-out times of the original plugin.
* IsomodInOut for 5 seconds. Different fade-in and fade-out times.
* IsomodEnvelope for 5 seconds. Attack/Decay/Sustain/Release envelope segments.  
  
Blog post from Brian Slartsani's blog The Dynamic State and does a good job of describing how to use the original Isochronic Modulator plugin. 
(https://thedynamicstate.wordpress.com/2016/12/24/creating-isochronic-tones-with-audacity/)
  
License matching the original plugin license: GNU GENERAL PUBLIC LICENSE Version 3    
(https://www.gnu.org/licenses/gpl.txt)  
