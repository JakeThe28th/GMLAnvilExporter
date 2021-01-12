// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function region_section_get_block(block_x, block_y, block_z, offset_x, offset_z,section){
	
	//Determine index size
	//Find the long
	//Find the index of the block in the long
	//convert to number
	//read from palette
	//return palette entry ds
	
				
		
			
		var section_y = nbt_path(section, ";","Y",0)[? "payload"]
				
		
		//Coords for .obj
			//Offset relative coords block_y the export offset (Offset, but close to mesh origin.)
			var bl_off_x = block_x + offset_x
			var bl_off_z = block_z + offset_z
	
			//Offset Y block_y section
			var bl_off_y = block_y + (section_y*16)//+2*section_y
		
		
		var blockstates = nbt_path(section, ";","BlockStates",0)
		if blockstates >-1 blockstates = blockstates[? "payload"]
		
		var palette = nbt_path(section, ";","Palette",0)
		if palette >-1 palette = palette[? "payload"]
		
		//Read section data.
		if palette >-1 {
			
			//I know i'm meant to do this dynamically on a per bit level,
			//but i can't see exeeding 256 blockstates per section so i do the lazy.
			if ds_list_size(palette) < 16 var ind_size = 4 
			if ds_list_size(palette) > 16 var ind_size = ceil(log2(ds_list_size(palette)) / log2(2))
			
			if ds_list_size(palette) > 255 show_error("Too many blocks in one place. \n Tell jake to stop being lazy and actually implement this feature properly!", false)
			
			
			//Get indexes
			//YZX
			var block_index = block_y * (chunk_size*chunk_size) + block_z * chunk_size + block_x
		//	if block_index = 0
			var indexes_per_long = floor( 64/ind_size)
			var long_index = floor(block_index / (indexes_per_long))
			var block_index_long = block_index mod indexes_per_long
			
			if section_y = 4 {
				var error = "e"
				}

			
			var temp = blockstates[| long_index]
			if temp = undefined {
				var error = "e"
				}
				
				var bits = floor(ds_list_size(blockstates) / 64)
				var clean = (power(2, bits) - 1)
				var startbit = ceil((block_index mod indexes_per_long) * bits)
			var index = (blockstates[| long_index]) >> startbit & clean
			
			//var longstring = int_to_binary(blockstates[| long_index],64)
			
			//Read state
			//var index = string_copy(longstring, (block_index_long*ind_size)-ind_size, ind_size)
			//index = binary_to_int(index)
			
			if palette[| index] = undefined {
				return -1
				var error = "e"
				}
				
			var states = ""
			var block_id = nbt_path(palette[| index],";","Name",0)[? "payload"][? "payload"]
			
				
			var block_properties = nbt_path(palette[| index],";","Properties",0)
				
			if block_properties > -1 {
				//Repeat through properties, add to string.
				var properties_i = 0
				block_properties = block_properties[? "payload"]
				var prefix_properties = ""
					
				repeat ds_list_size(block_properties) {
					var current_property = block_properties[| properties_i]
					var current_string_tag = current_property[? "payload"]
					
					states += prefix_properties+string(current_property[? "name"])+"="+string(current_string_tag[? "payload"])
					
					prefix_properties = ","
					properties_i++
					}
					
				}
				//debug_log("OUT", block_id + " x: " + string(bl_off_x)+ " y: " + string(bl_off_y)+ " z: " + string(bl_off_z))
				mc2obj_state(bl_off_x,bl_off_y,bl_off_z,block_id,states,obj,vertice_count,vertice_texture_count,cullfaces,mtl,mtl_index)
			}
}