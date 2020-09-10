if instance_exists(player) and place_meeting(x,y,player) and player.groundY <= y+z {
	if player.map != id {
		var surface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
		buffer_set_surface(surfaceBuffer, surface, 0, 0, 0)
		draw_surface(surface,x,y)
	}
}

//var surface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
//buffer_set_surface(surfaceBuffer, surface, 0, 0, 0)
//draw_surface(surface,x + 200,y)