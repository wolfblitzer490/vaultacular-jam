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
	
	
	////	DEBUG MENU
	var menu = {
		width: 200,
		height: 100,
		x: 640 - 200 - 16,
		y: 30,
	}
	
	draw_set_color(c_gray)
	draw_rectangle(menu.x,menu.y,menu.x+menu.width,menu.y+menu.height,false)
	
	var bX = menu.x + 15
	var bY = menu.y + 15
	var bWidth = 90
	var bHeight = 30
	if point_in_rectangle(mouse_gui_x,mouse_gui_y,bX,bY,bX+bWidth,bY+bHeight) {
		draw_set_color(c_ltgray)
		if input.mouseLeftPress {
			app.debug_GOBLIN_ATTACK = true
			class_npc.dialogueIndex = 7
		}
	}
	else {
		draw_set_color(c_dkgray)
	}
	draw_rectangle(bX,bY,bX+bWidth,bY+bHeight,false)
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(bX+bWidth/2,bY+bHeight/2,"AHHHHH")
	
}