z = 0

surfaceBuffer = -1

depth = -1

function createSurface() {
	var surface = surface_create(room_width, room_height) // sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale
	
	surface_set_target(surface)
	
	var LayerID = layer_get_id("Tiles_Rocks")
	var tileLayerID = layer_tilemap_get_id(LayerID)
	
	draw_tilemap(tileLayerID, 0,0)
	
	surface_reset_target()
	
	var finalSurface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale)
	
	surface_copy_part(finalSurface,0,0, surface, x,y, sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale)
	
	var width = surface_get_width(finalSurface)
	var height = surface_get_height(finalSurface)
	
	surfaceBuffer = buffer_create(width*height*4, buffer_grow, 1)
	
	buffer_get_surface(surfaceBuffer, finalSurface, 0, 0, 0)	
	
	var Break = 0
	
}

createSurface()