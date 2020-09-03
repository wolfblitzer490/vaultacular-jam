if on {
	
	
	if instance_exists(player) with player {
		
		//	Draw collision mask
		draw_set_alpha(0.5)
		draw_set_color(c_red)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		
	}
	
	if instance_exists(collisionMap) with collisionMap {
		//	Pit
		if z == -1 {
			draw_set_color(c_orange)
			draw_rectangle(x,y, x+sprite_get_width(sprite_index)*image_xscale, y+sprite_get_height(sprite_index)*image_yscale,false)
		}
	}
	
draw_reset()

}