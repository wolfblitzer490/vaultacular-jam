if live_call() return live_result

//	Draw shadow
if !falling {
	draw_set_color(c_black)
	var Alpha = 1.25 - (abs(groundY - (y-z)) / 100)
	Alpha = clamp(Alpha, 0.2, 0.35)
	draw_set_alpha(Alpha)
	var Width = 6 + (24 * Alpha)
	var Height = 1 + (8 * Alpha)
	draw_ellipse(groundX-Width,groundY-Height,groundX+Width,groundY+Height,false)


	draw_reset()
}

if !fallen draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)