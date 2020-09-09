switch(state)
{
	#region Free State
		case state.free:
			hspd = (input.keyRight - input.keyLeft) + gamepad_axis_value(0, gp_axislh)
			vspd = (input.keyDown - input.keyUp) + gamepad_axis_value(0, gp_axislv)
			
			if stamina < staminaMax {
							
				//	Determine recharge rate
				var division = staminaMax / 5
				if stamina >= division * 4 {
					staminaRechargeRate = 1
				} else if stamina >= division * 3 and stamina < division * 4 {
					staminaRechargeRate = 2
				} else if stamina >= division * 2 and stamina < division * 3 {
					staminaRechargeRate = 2	
				} else if stamina >= division * 1 and stamina < division * 2 {
					staminaRechargeRate = 4	
				} else if stamina < division {
					staminaRechargeRate = 4
				}
				
	
				staminaRecharge++
				if staminaRecharge >= staminaRechargeRate {
					stamina++
					staminaRecharge = 0
				}
			}

			if onGround and !falling and input.keyJump {
				setThrust(6)
			}

			if !onGround applyThrust()
			
			var attackStaminaCost = 15
			if onGround and input.keyAttack and stamina >= attackStaminaCost {
				state = state.attack
				stamina -= attackStaminaCost
				moveForce = 3
				switch(sprite_index) {
					case s_player_idle_front:
					case s_player_walk_front: 
						sprite_index = s_player_attack_front
						image_xscale *= -1
					break
					
					case s_player_idle_side: 
					case s_player_walk_side: sprite_index = s_player_attack_side break
					
					case s_player_idle_back:
					case s_player_walk_back: 
						sprite_index = s_player_attack_back 
						image_xscale *= -1
					break
					
				}
				image_index = 0
				image_speed = 1
				exit
			}

			if falling fall()

			var maxMoveSpeed = 2

			//	Inputting movement
			if (hspd != 0 or vspd != 0) {
	
				if onGround and !falling {
					if vspd == 0 {
						sprite_index = s_player_walk_side
					} else {
						if vspd > 0 sprite_index = s_player_walk_front
						else sprite_index = s_player_walk_back
					}
					
				}
				if hspd != 0 and sign(image_xscale) != sign(hspd) image_xscale = xscale * sign(hspd)
				image_speed = moveForce / maxMoveSpeed
	
				moveDirection = point_direction(0,0,hspd,vspd)
				moveForce += 0.15 * clamp(abs(hspd)+abs(vspd),-1,1)
	
				if falling moveForce *= xscale
	
				moveForce = clamp(moveForce, 0, maxMoveSpeed)
	
				setForce(moveForce, moveDirection)
				
				//debug.log("Moving at "+string_upper(string(moveForce)) + " force and in "+string_upper(string(moveDirection)) +" direction")
	
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
				y = groundY + z
			}
		break
	#endregion
	
	#region Attack State
		case state.attack:
		
			var attackStaminaCost = 30
			if attackCharge == -1 {
			
				if animation_end {
					if !input.keyAttackHold or attackCharged or stamina < attackStaminaCost {
						switch(sprite_index) {
							case s_player_attack_front: sprite_index = s_player_idle_front break
							case s_player_attack_side: sprite_index = s_player_idle_side break
							case s_player_attack_back: sprite_index = s_player_idle_back break
						}
				
						state = state.free	
						attackCharged = false
						attackCharge = -1
					}
				
					else {
						if attackCharge == -1 {
							switch(sprite_index) {
								case s_player_attack_side:
									image_index = 0
								break
								case s_player_attack_front:
									image_xscale *= -1
									image_index = 0
								break
								case s_player_attack_back:
									image_xscale *= -1
									image_index = 0
								break
							}
							image_speed = 0
							attackCharge++
						}
					}
				}
			}
			//	Charging attack
			else {
				if input.keyAttackHold {
					image_speed = 0
					attackCharge++	
					
					if attackCharge >= 30 {
						attackCharged = true
						image_speed = 1
						attackCharge = -1
						moveForce = 5
						stamina -= attackStaminaCost
					}
				}
				
				else {
					attackCharged = true
					image_speed = 1
					attackCharge = -1
					moveForce = 5
					stamina -= attackStaminaCost
				}
			}
			
			if moveForce > 0 {
				moveForce -= 0.5
				setForce(moveForce, moveDirection)	
			}
			
			applyMovement()
			
			x = groundX
			y = groundY
			
		break
	#endregion
}

depth = -y