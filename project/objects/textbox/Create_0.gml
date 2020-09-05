textComplete = ""
textCurrent = ""

textTimerMax = 5
textTimer = -1
textIndex = 1

distanceTarget = -1

textScrolling = true

responses = []

function scroll() {
	if textTimer <= 0 {
		textTimer = textTimerMax
		
		textCurrent += string_char_at(textComplete, textIndex)
		
		textIndex++
		
		if textIndex > string_length(textComplete) textScrolling = false
	}
	else textTimer--
	
	if input.keyInteract {
		if textCurrent != textComplete {
			textCurrent = textComplete
			textScrolling = false
		}
	}
}