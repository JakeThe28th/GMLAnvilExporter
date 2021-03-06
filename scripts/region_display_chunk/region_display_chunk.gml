// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function region_display_chunk(chunk_x, chunk_z, pix_x, pix_y, block_textures, region){
	
	var chunk_filename = nbt_save_dir + string(chunk_x)+","+string(chunk_z)+".mcc"
	
	//If chunk isn't already opened, open it.
	if !file_exists(chunk_filename) {
		var a = 8
		var reg = region_open_chunk(chunk_x, chunk_z, region) 
		if reg < 0 return -1
		//-1 = no mca
		//-2 = no chunk
		//-3 = no section
		//-4 = no block
		}
	
		
	var chunk = nbt_start(chunk_filename)
	
	var heightmaps = nbt_path(chunk, ";", "Level;Heightmaps", 1)[? "payload"]
	if  ds_list_size(heightmaps) > 0 {
	
	var heightmaps = nbt_path(chunk, ";", "Level;Heightmaps;WORLD_SURFACE", 1) 
	if  heightmaps > -1 heightmaps = heightmaps[? "payload"] else heightmaps = nbt_path(chunk, ";", "Level;Heightmaps;WORLD_SURFACE_WG", 1)[? "payload"]
	
		} else return -1
	
	var block_x = 0
	var block_z = 0
	repeat chunk_size*chunk_size {
	
	var index = block_z * chunk_size + block_x
	
	var indexes_per_long = floor(64/heightmap_index_size) //The amount of indexes in a long value (64 bits).
	var long_index = floor(index / (indexes_per_long)) //The index of the long that contains the block.
	
	var bits = heightmap_index_size
	var clean = (power(2, bits) - 1)								
	var startbit = ceil((index mod indexes_per_long) * bits)	
	var y_level = (heightmaps[| long_index]) >> startbit & clean //Get the block's Y level.
	
	//draw_point_color(block_x, block_z, make_color_hsv(0, 0, y_level))
	draw_sprite_ext(spr_pixel, 0, block_x, block_z, 1, 1, 0, make_color_hsv(0, 0, y_level), 1)
	
	 block_x++
	 if block_x = chunk_size {
		  block_x = 0
		  block_z++ 
		 }
	}
	
	ds_map_destroy(chunk)
	
}