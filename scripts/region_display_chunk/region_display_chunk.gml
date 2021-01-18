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
	
	var heightmaps = nbt_path(chunk, ";", "Level;Heightmaps;WORLD_SURFACE", 1)[? "payload"]
	
	
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
	
	
	
	var section_y = floor(y_level/16)

	var ind = region_section_get_block(block_x, floor(y_level/16), block_z, region_chunk_get_section(floor(section_y), chunk))
	var ind = split_string(ind, "|")[1]
	
	var col = c_white
	
	//switch (ind) {
	//	case "minecraft:stone": var col = c_gray break;
	//	case "minecraft:snow": var col = c_white break;
	//	case "minecraft:spruce_leaves": var col = c_green break;
	//	case "minecraft:grass_block": var col = c_lime break;
	//	}
	
	
	var hue = color_get_hue(col)
	var sat = color_get_saturation(col)
	
	draw_point_color(block_x,block_z,make_color_hsv(hue, sat, y_level))
	
	 block_x++
	 if block_x = chunk_size {
		  block_x = 0
		  block_z++ 
		 }
	}
	
}