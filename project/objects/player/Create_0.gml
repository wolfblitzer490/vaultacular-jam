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
		if !place_meeting(groundX + sign(xx), groundY, collision) groundX += sign(xx)
	}
	
	for(var Y=0;Y<abs(yy);Y++) {
		if !place_meeting(groundX, groundY + sign(yy), collision) {
			groundY += sign(yy)
			if !onGround y += sign(yy)	
		}
	}
	
	xx = 0
	yy = 0
	
}