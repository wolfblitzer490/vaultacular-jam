if textScrolling scroll()

else if input.keyInteract {
	instance_destroy()
	gui.interactionCooldown = 15	
}

var distance = 200
if distanceTarget > -1 and instance_exists(distanceTarget) and point_distance(distanceTarget.x,distanceTarget.y, player.x,player.y) >= distance {
	instance_destroy()	
}