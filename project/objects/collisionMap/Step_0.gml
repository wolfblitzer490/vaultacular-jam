if instance_exists(player) and place_meeting(x,y,player) and player.groundY < y+z {
	if player.map != id {
		depth = player.depth - 1
	}
}