hspd = 0
vspd = 0
onGround = true
groundX = x
groundY = y
grav = 0.4
z = 0
xx = 0
yy = 0
xscale = image_xscale
yscale = image_yscale
moveForce = 0
moveDirection = -1
thrust = 0
map = -1
falling = false
fallen = false
preFalling = false

mask_index = s_player_collision

function setThrust(Thrust) {
	onGround = false
	thrust = Thrust
}

function fall() {
	var Lerp = 0.05
	xscale = lerp(xscale, sign(image_xscale) * 0.05, Lerp)
	yscale = lerp(yscale, sign(image_yscale) * 0.05, Lerp)
	image_xscale = xscale
	image_yscale = yscale
	
	//thrust -= 0.05
	thrust -= grav
	z += thrust
	
	if xscale < 0.15 or yscale < 0.15 {
		fallen = true	
	}
}

function applyThrust() {
	
	thrust -= grav
	z += thrust
		
	if y-z >= groundY {
		if map > -1 and map.z == -1 and thrust > -3 {
			preFalling = true
			exit
		}
		//	Falling
		if (place_meeting(x,y-z, collisionMap) and instance_place(x,y-z,collisionMap).z == -1)
		or (map > -1 and map.z == -1) {
			falling = true
		}
		onGround = true
		y = groundY
		if !preFalling z = 0
		thrust = 0
	}
	
	
}

function setForce(force, direction) {
	
	xx = lengthdir_x(force, direction)
	yy = lengthdir_y(force, direction)

}
	
function changeMap(Map) {
	
	var oldMap = -1
	var Z = -1
	
	if map == -1 Z = 0
	else Z = map.z
	
	oldMap = map
	
	//	Changing to a map
	if Map > -1 {
		
		if Map.z == -1 {
			if rectangle_in_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom, Map.x,Map.y, Map.x+(sprite_get_width(Map.sprite_index)*Map.image_xscale), Map.y+(sprite_get_height(Map.sprite_index)*Map.image_yscale)) != 1 {
				exit	
			}
		}
		
		//	I am stepping down
		if Z > Map.z {
			var Done = false
			var DoneValue = groundY + Z
			while !Done {
				if Map.z == -1 {
					Done = true
					onGround = false	
				} else if preFalling {
					preFalling = false
				}
				if place_meeting(groundX, groundY + sign(yy), collision) Done = true
				if groundY = DoneValue Done = true
				if !Done groundY += 1
			}
			if groundY > y onGround = false
		}
		//	I am jumping up
		else {
			var Done = false
			var DoneValue = groundY - Map.z
			while !Done {
				if Map.z == -1 {
					Done = true
					onGround = false
				} else if preFalling {
					preFalling = false
				}
				if place_meeting(groundX, groundY + sign(yy), collision) Done = true
				if groundY = DoneValue Done = true
				if !Done groundY -= 1
			}
		}
		
	}
	//	Changing to no map/z = 0
	else {
		var Done = false
		var DoneValue = groundY + Z
		while !Done {
			if Z == -1 {
				Done = true
				onGround = false
			} else if preFalling {
				preFalling = false	
			}
			if place_meeting(groundX, groundY + sign(yy), collision) Done = true
			if groundY = DoneValue Done = true
			if !Done {
				if DoneValue > groundY groundY += 1
				else if DoneValue < groundY groundY -= 1
			}
		}

		if groundY > y onGround = false
	}
	
	map = Map
}

function applyMovement() {
	
	var current_xscale = image_xscale
	var current_yscale = image_yscale
	
	image_xscale = 1
	image_yscale = 1
	
	if !falling {
	
	for(var X=0;X<abs(xx);X++) {
		if !place_meeting(groundX + sign(xx), groundY, collision) {
			if place_meeting(groundX + sign(xx), groundY, collisionMap) {
				var Map = instance_place(groundX + sign(xx), groundY, collisionMap)
				if (z >= Map.z or map == Map) {
					groundX += sign(xx)
					if map == -1 or (map > -1 and map != Map) {
						changeMap(Map)
					}
				}
			//	Not colliding with collision or a collisionMap
			}
			else {
				groundX += sign(xx)
				if map > -1 {
					changeMap(-1)	
				}
			}
		}
		//	Collision happening
		else {
			var Collision = instance_place(groundX + sign(xx), groundY, collision)
			if Collision.topWall {
				//	If we are higher than the topWall
				if z >= Collision.map.z {
					if map == -1 or map != Collision.map {
						changeMap(Collision.map) 
					} else if map == Collision.map {
						changeMap(-1)
					}
				}
				else if map == Collision.map {
					changeMap(-1)
				}
			}
		}
	}
	
	for(var Y=0;Y<abs(yy);Y++) {
		if !place_meeting(groundX, groundY + sign(yy), collision) {
			if place_meeting(groundX, groundY + sign(yy), collisionMap) {
				var Map = instance_place(groundX, groundY + sign(yy), collisionMap)
				if (z >= Map.z or map == Map) {
					groundY += sign(yy)
					if !onGround y += sign(yy)
					if map == -1 or (map > -1 and map != Map) {
						//map = Map
						//groundY -= Map.z
						changeMap(Map)
					}
				}
			}
			//	Not colliding with collision or collisionMap
			else {
				groundY += sign(yy)
				if !onGround y += sign(yy)	
				if map > -1 {
					//groundY += map.z
					//if groundY > y onGround = false
					//map = -1
					changeMap(-1)
				}	
			}
		}
		//	Hitting collision
		else {
			var Collision = instance_place(groundX, groundY + sign(yy), collision)
			if Collision.topWall {
				if z >= Collision.map.z {
					if map == -1 or map != Collision.map {
						map = Collision.map
						groundY -= map.z
						while place_meeting(groundX,groundY,Collision) {
							groundY -= 1	
						}
						//changeMap(Collision.map) 
					} else if map == Collision.map {
						groundY += map.z
						while place_meeting(groundX,groundY,Collision) {
							groundY += 1	
						}
						if groundY > y onGround = false
						map = -1	
						//changeMap(-1)
					}
				}
				else if map == Collision.map {
					groundY += map.z
					while place_meeting(groundX,groundY,Collision) {
						groundY += 1	
					}
					if groundY > y onGround = false
					map = -1
					//changeMap(-1)
				}
			}
		}
	}
		
	}
	
	else {
		for(var X=0;X<abs(xx);X++) {
			if instance_position(groundX + sign(xx), groundY, map)	groundX += sign(xx)
		}
		
		for(var Y=0;Y<abs(yy);Y++) {
			if instance_position(groundX, groundY + sign(yy), map) groundY += sign(yy)
		}
	}
	
	xx = 0
	yy = 0
	
	image_xscale = current_xscale
	image_yscale = current_yscale
	
}