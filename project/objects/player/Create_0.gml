hspd = 0
vspd = 0
onGround = true
groundX = x
groundY = y
grav = 0.4
z = 0
xx = 0
yy = 0
moveForce = 0
moveDirection = -1
thrust = 0
map = -1

mask_index = s_player_collision

function setThrust(Thrust) {
	onGround = false
	thrust = Thrust
}

function applyThrust() {
	
	thrust -= grav
	z += thrust
		
	if y-z >= groundY {
		onGround = true
		y = groundY
		z = 0
		thrust = 0
	}
	
	
}

function setForce(force, direction) {
	
	xx = lengthdir_x(force, direction)
	yy = lengthdir_y(force, direction)

}

function applyMovement() {
	
	for(var X=0;X<abs(xx);X++) {
		if !place_meeting(groundX + sign(xx), groundY, collision) {
			if place_meeting(groundX + sign(xx), groundY, collisionMap) {
				var Map = instance_place(groundX + sign(xx), groundY, collisionMap)
				if z >= Map.z or map == Map {
					groundX += sign(xx)
					if map == -1 {
						map = Map
						groundY -= Map.z
					}
				}

			}
			else {
				groundX += sign(xx)
				if map > -1 {
					groundY += map.z
					if groundY > y onGround = false
					map = -1	
				}
			}
		}
	}
	
	for(var Y=0;Y<abs(yy);Y++) {
		if !place_meeting(groundX, groundY + sign(yy), collision) {
			if place_meeting(groundX, groundY + sign(yy), collisionMap) {
				var Map = instance_place(groundX, groundY + sign(yy), collisionMap)
				if z >= Map.z or map == Map {
					groundY += sign(yy)
					if !onGround y += sign(yy)
					if map == -1 {
						map = Map
						groundY -= Map.z
					}
				}
			}
			else {
				groundY += sign(yy)
				if !onGround y += sign(yy)	
				if map > -1 {
					groundY += map.z
					if groundY > y onGround = false
					map = -1
				}	
			}
		}
		//	Hitting collision
		else {
			var Collision = instance_place(groundX, groundY + sign(yy), collision)
			if Collision.topWall {
				if z >= Collision.map.z {
					if map == -1 {
						map = Collision.map
						groundY -= map.z
						while place_meeting(groundX,groundY,Collision) {
							groundY -= 1	
						}
					} else if map == Collision.map {
						groundY += map.z
						while place_meeting(groundX,groundY,Collision) {
							groundY += 1	
						}
						if groundY > y onGround = false
						map = -1	
					}
				}
				else if map == Collision.map {
					groundY += map.z
					while place_meeting(groundX,groundY,Collision) {
						groundY += 1	
					}
					if groundY > y onGround = false
					map = -1
				}
			}
		}
	}
	
	xx = 0
	yy = 0
	
}