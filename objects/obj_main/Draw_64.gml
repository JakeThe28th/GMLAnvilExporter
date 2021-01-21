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
var d_chunk_x = 6
var d_chunk_z = 6
repeat 6*6 {
	//Set target
	surface_set_target(surf)
	//Run render script, pixel at 0 0
	region_display_chunk(chunk_x, chunk_z, 0, 0, resources, region)
	
	obj = buffer_create(1, buffer_grow, 1)
	mtl = file_text_open_write(mtl_out_dir + string(chunk_x) + "_" + string(chunk_z) +".mtl")
	
	region_export_chunk(chunk_x, chunk_z, chunk_x, chunk_z, resources, region, obj, mtl)
	
	buffer_save(obj, obj_out_dir + string(chunk_x) + "_" + string(chunk_z) + ".obj")
	file_text_close(mtl)
	
	//reset target
	surface_reset_target()
	//Set target
	surface_set_target(surfbig)
	//draw surface, 4 times size.
	draw_surface_ext(surf, (d_chunk_x*16)*4, (d_chunk_z*16)*4, 4, 4, 0, c_white, 1)
	surface_reset_target()
	//Set target
	chunk_x--
	d_chunk_x--
	if chunk_x = -6 {
		chunk_x = 0
		chunk_z--
	}
	if d_chunk_x = 0 {
		d_chunk_x = 6
		d_chunk_z--
	}
}

spritetemp = sprite_create_from_surface(surfbig,0,0,(chunk_size*32)*4,(chunk_size*32)*4,0,0,0,0)

//buffer_save(obj, obj_out_dir)
//file_text_close(mtl)

}

if spritetemp > -1 draw_sprite(spritetemp, 0,0 ,0)