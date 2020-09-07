if point_distance(x,y, player.x,player.y) < 200 and !damaged {
	player.mask_index = player.sprite_index
	if place_meeting(x,y,player) and player.state == state.attack {
		knockbackDirection = point_direction(player.x,player.y, x,y)
		knockbackForce = 5
		damaged = true
		damagedTimer = 30
		damagedFlash = true
	}
	player.mask_index = s_player_collision
}

if knockbackForce > 0 {
	knockbackForce -= 0.5
	setForce(knockbackForce, knockbackDirection)
}

if damagedTimer > -1 {
	damagedTimer--
	if damagedTimer < 15 {
		damagedFlash = false	
	}
}
else {
	damaged = false	
}

applyMovement()

if onGround {
	x = groundX
	y = groundY
}
else {
		
}