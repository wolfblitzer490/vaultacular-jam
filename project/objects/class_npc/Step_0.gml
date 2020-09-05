if point_distance(x,y, player.x,player.y-(sprite_get_height(player.sprite_index)/4)) < 100 {
	if !interaction or !gui.interaction {
		interaction = true
		gui.interaction = true
		gui.interactionID = id
	}
}

else {
	if interaction {
		interaction = false
		gui.interaction = false
		if gui.interactionID == id gui.interactionID = -1
	}
}