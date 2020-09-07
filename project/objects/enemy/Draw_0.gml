if damagedFlash {
	shader_set(shader_flash)	
}

if !fallen draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

shader_reset()