if on {
	
	if instance_exists(player) with player {
		var XX = 15
		var YY = 15
		draw_set_color(c_black)
		draw_set_alpha(1)
		draw_text(XX,YY, "x: "+string(x)) YY += 15
		draw_text(XX,YY, "y: "+string(y)) YY += 15
		draw_text(XX,YY, "z: "+string(z)) YY += 15	
	}
	
	
}