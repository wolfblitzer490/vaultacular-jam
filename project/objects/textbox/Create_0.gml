textComplete = "My linky stays stinky"
textCurrent = ""

textTimerMax = 5
textTimer = -1
textIndex = 1

textScrolling = true

function scroll() {
	if textTimer <= 0 {
		textTimer = textTimerMax
		
		textCurrent += string_char_at(textComplete, textIndex)
		
		textIndex++
	}
	else textTimer--
}