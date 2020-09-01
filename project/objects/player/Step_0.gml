hspd = input.keyRight - input.keyLeft
vspd = input.keyDown - input.keyUp

if onGround and input.keyJump {
	setThrust(10)
}

if !onGround applyThrust()

var maxMoveSpeed = 5

//	Inputting movement
if (hspd != 0 or vspd != 0) {
	
	if onGround sprite_index = s_walk
	if hspd != 0 image_xscale = hspd
	image_speed = moveForce / maxMoveSpeed
	
	moveDirection = point_direction(0,0,hspd,vspd)
	moveForce += 0.5
	
	moveForce = clamp(moveForce, 0, maxMoveSpeed)
	
	setForce(moveForce, moveDirection)
	
}
//	Not inputting movement
else {
	image_speed = moveForce / maxMoveSpeed
	if moveForce > 0 {
		moveForce -= 0.5
		setForce(moveForce, moveDirection)
	} else {
		if onGround sprite_index = s_idle	
	}
}

applyMovement()

if !onGround {
	x = groundX
	if thrust > 0 {
		sprite_index = s_jump_up	
	} else {
		sprite_index = s_jump_down	
	}
}

else {
	x = groundX
	y = groundY
}

depth = -y