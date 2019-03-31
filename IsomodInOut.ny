;nyquist plug-in
;version 1
;type process
;categories "http://lv2plug.in/ns/lv2core#ModulatorPlugin"
;name "IsoModInOut..."
;action "Modulating..."
;info "Isochronic Modulator by Steve Daulton.\nIn/Out modification by Elliot Mebane.\nGPL v.2\nhttp://easyspacepro.com\nhttp:www.roguish.com\nhttps://wiki.audacityteam.org/wiki/Nyquist_Effect_Plug-ins#Isochronic_modulator\n\n'Pulse Width' controls the length of each pulse.\n'Fade Time In' adjusts the fade in time of the pulses as a percentage of the Pulse Width time.\nFade Time Out' adjusts the fade out time of the pulses as a percentage of the Pulse Width time.\nThe modulation frequency (speed) and depth transform\ngradually from the initial settings to the final settings.\n\nPlug-in provided as an audio processing effect.\nThe author does not endorse or claim any relevance\nto the theory or practice of brainwave entrainment."
;nyquist language ref: "http://www.cs.cmu.edu/~rbd/doc/nyquist/index.html"

;control pw "Pulse Width [50%=Square]" real "%" 50 0 100
;control ftin "Fade Time In" real "%" 10 0 100
;control ftout "Fade Time Out" real "%" 80 0 100
;control startf "Initial Modulation Frequency" real "Hz" 10 1 100
;control endf "Final Modulation Frequency" real "Hz" 10 1 100
;control starta "Initial Modulation Depth" int "%" 100 0 100
;control enda "Final Modulation Depth" int "%" 100 0 100

; adjusted ftin/ftout to represent percentages of the pulse width time. 
; e.g., a pulse width time of 30% with fade in time of 10% will have a fade-in value of .3*.1 = .03
(setq pw (/ pw 100.0))
(setq ftin (/ ftin 100.0))
(setq ftin (* ftin pw))
;orig (setq ftin (* ftin (min pw (- 1 pw)) 2))
(setq ftout (/ ftout 100.0))
(setq ftout (* ftout pw))
;orig (setq ftout (* ftout (min pw (- 1 pw)) 2))
 

; set tremolo *waveform* 
;orig (abs-env (list (pwl ftin 1 (- pw ftin) 1 (+ pw ftin) -1 (- 1 ftin) -1 1 0)(hz-to-step 1.0) t)))
; added line breaks to clarify the structure. 
; final pwl (piece-wise linear envelope) pair includes 
; the initial value at time 0 and 
; the final value -1 at time 1
; note that 1 leaves the scale at its starting level, 0 cuts it in half, -1 reduces it to 0
; http://www.cs.cmu.edu/~rbd/doc/nyquist/part2.html#15
; http://www.cs.cmu.edu/~rbd/doc/nyquist/part8.html#index407
(setq *waveform*
   (abs-env 
		(list 
			(pwl  
				0 -1
				ftin 1
				ftout 1 
				pw -1
				1 -1
			)
			(hz-to-step 1.0) t
		)
	)
) 

; Function to generate sweep tone
(defun sweep (sf ef)
     (mult 0.5 (sum 1.0 (fmlfo (pwlv sf 1.0 ef) *waveform*))))

(let* ((starta (/ starta 100.0))
   (enda (/ enda 100.0))
   (wet (pwlv starta 1 enda))
   (dry (sum 1 (mult wet -1))))
   (mult s (sum dry (mult wet (sweep startf endf)))))
