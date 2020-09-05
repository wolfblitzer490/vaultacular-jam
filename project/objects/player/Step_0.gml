switch(state)
{
	#region Free State
		case state.free:
			hspd = input.keyRight - input.keyLeft
			vspd = input.keyDown - input.keyUp

			if onGround and !falling and input.keyJump {
				setThrust(6)
			}

			if !onGround applyThrust()

			if falling fall()

			var maxMoveSpeed = 3

			//	Inputting movement
			if (hspd != 0 or vspd != 0) {
	
				if onGround and !falling {
					if hspd != 0 and vspd == 0 sprite_index = s_player_walk_side
					if hspd == 0 and vspd > 0 sprite_index = s_player_walk_front
					else if vspd < 0 sprite_index = s_player_walk_back
				}
				if hspd != 0 and sign(image_xscale) != sign(hspd) image_xscale = xscale * sign(hspd)
				image_speed = moveForce / maxMoveSpeed
	
				moveDirection = point_direction(0,0,hspd,vspd)
				moveForce += 0.5
	
				if falling moveForce *= xscale
	
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
					if onGround and !falling {
						switch(sprite_index) {
							case s_player_walk_front: sprite_index = s_player_idle_front break
							case s_player_walk_side: sprite_index = s_player_idle_side break
							case s_player_walk_back: sprite_index = s_player_idle_back break
						}
						image_speed = 1
					}
				}
			}

			applyMovement()

			if !onGround {
				x = groundX
				if thrust > 0 {
					//sprite_index = s_jump_up	
				} else {
					//sprite_index = s_jump_down	
				}
			}

			else {
		x = groundX
		y = groundY
	}
		break
	#endregion
	
	#region
		case state.attack:
			
			
			
			
		break
	#endregion
}



depth = -y