spawnpoint = false

dinged = false
dingSoundPlayed = false
function ding() {
	sprite_index = s_bell_animation
	
	if animation_end {
		dinged = false
		sprite_index = s_bell
	}
}