var centerX = display_get_gui_width()/2

var width = string_width(textComplete) + 32
var height = string_height(textComplete) + 32

var X = centerX - width/2
var Y = display_get_gui_height() - height - 32

draw_set_color(c_black)
draw_roundrect(X-2,Y-2, X+width+2,Y+height+2, false)

draw_set_color(c_gray)
draw_roundrect(X,Y, X+width,Y+height, false)

draw_set_color(c_white)
draw_text(X+15,Y+15,textCurrent)