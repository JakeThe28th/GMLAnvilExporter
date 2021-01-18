vh = camera_get_view_height(view_camera[0])

//region_display_chunk(0, 0, 0, 0, "C:\\Ussers\\nickl\\AppData\\Roaming\\.minecraft\\versions\\1.16.1\\1.16.1\\", region)

//drawsprite = Sprite1
//sprite_scale = vh/sprite_get_height(drawsprite)
//draw_sprite_ext(drawsprite, 0, 0, 0, sprite_scale, sprite_scale, 0, c_white, 1)


//IF a chunk doesn't exist in `chunk_sprite_ds`, render it.
//Re render if the height limits are changed aswell

if spritetemp < 0 {

//Create surface
var surf = surface_create(chunk_size, chunk_size)
var surfbig = surface_create((chunk_size*32)*4, (chunk_size*32)*4)

var chunk_x = 0
var chunk_z = 0
repeat 6*6 {
	//Set target
	surface_set_target(surf)
	//Run render script, pixel at 0 0
	region_display_chunk(chunk_x, chunk_z, 0, 0, resources, region)
	//reset target
	surface_reset_target()
	//Set target
	surface_set_target(surfbig)
	//draw surface, 4 times size.
	draw_surface_ext(surf, (chunk_x*16)*4, (chunk_z*16)*4, 4, 4, 0, c_white, 1)
	surface_reset_target()
	//Set target
	chunk_x++
	if chunk_x = 6 {
		chunk_x = 0
		chunk_z++
	}
}

spritetemp = sprite_create_from_surface(surfbig,0,0,(chunk_size*32)*4,(chunk_size*32)*4,0,0,0,0)

}

if spritetemp > -1 draw_sprite(spritetemp, 0,0 ,0)