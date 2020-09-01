//	Draw shadow
draw_set_color(c_black)
draw_set_alpha(0.5)
var Width = 24
var Height = 8
draw_ellipse(groundX-Width,groundY-Height,groundX+Width,groundY+Height,false)

draw_reset()

draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)