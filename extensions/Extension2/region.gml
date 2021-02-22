#define region_export_chunk_EXT 
//(chunk_x, chunk_z, chunk_exp_x, chunk_exp_z, resources_dir, region, obj, mtl)
	var chunk_x = argument0
	var chunk_z = argument1
	var chunk_exp_x = argument2
	var chunk_exp_z = argument3
	var resources_dir = argument4
	var region = argument5
	var obj = argument6
	var mtl = argument7
	
	
	
	var chunk_filename = nbt_save_dir + string(chunk_x)+","+string(chunk_z)+".mcc"
	
	//If chunk isn't already opened, open it.
	if !file_exists(chunk_filename) {
		var a = 8
		if region_open_chunk(chunk_x, chunk_z, region) < 0 return -1
		//-1 = no mca
		//-2 = no chunk
		//-3 = no section
		//-4 = no block
		}
		
	var chunk = nbt_start(chunk_filename)
	
	var section_list = nbt_path(chunk, ";", "Level;Sections", 1)[? "payload"]
	
	
	//Get the section Y, for offsetting Y coords.
	var section_y = 0 
	
	//Relative to chunk section block coords
	var block_x = 0
	var block_y = 0
	var block_z = 0
	
	
	//Coords for .obj
	//Offset relative coords by the export offset (Offset, but close to mesh origin.)
	var bl_off_x = block_x + chunk_exp_x
	var block_ex_z = block_z + chunk_exp_z
	
	//Offset Y by section
	var bl_off_y = block_y + section_y*16
	
	
	var i = 0
		repeat ds_list_size(section_list) {
			
		var current_section = section_list[| i]
		
		var section_y = nbt_path(current_section, ";","Y",0)[? "payload"]
		
		buffer_write(obj, buffer_text,"o Section_"+string(section_y))
		buffer_write(obj, buffer_text, chr($000D) + chr($000A))
		

		#region Relative to chunk section block coords
		var block_x = 0
		var block_y = 0
		var block_z = 0
		
		#endregion
		
		//Get block data DS and Palette DS.
		var blockstates = nbt_path(current_section, ";","BlockStates",0)
		var palette = nbt_path(current_section, ";","Palette",0)
		
	if section_y < 4 blockstates = -1
		
	if blockstates >= 0 and palette >= 0 {
		blockstates = blockstates[? "payload"]
		palette = palette[? "payload"]
			
		//Get the number of bits required to store the highest palette index. 
		//If it's less than 4 bits, clamp it to 4 bits, since that's the minimum.
		var index_size = clamp(ceil(log2(ds_list_size(palette)) / log2(2)), 4, 512)
		
		var temp = undefined
		var i_air = 0
		do {
			
			temp = nbt_path(palette[| i_air],";","Name",0)[? "payload"]
		
			i_air++
			} until string_pos("air", temp) > 0 or i_air >= ds_list_size(palette)
			
			i_air--
		
		//Loop through blocks.
		do {
			
			#region Get the states|block_id	

			//Use script to get palette index.
			var block = region_blockstates_get_index(block_x, block_y, block_z, blockstates, index_size)
			
			if block != i_air {
			
				if palette[| block] = undefined then debug_log("Error", "Pallete index undefined")
				


			//Get the block id, and create a variable for blockstates
			var states = ""
			var block_id = nbt_path(palette[| block],";","Name",0)[? "payload"]
			
			//Get the properties DS
			var block_properties = nbt_path(palette[| block],";","Properties",0)
			
				
		#region Repeat through properties, add to string.
		if block_properties > -1 {
			var properties_i = 0
			block_properties = block_properties[? "payload"]
			var prefix_properties = ""
					
				//Loop
				repeat ds_list_size(block_properties) {
					var current_property = block_properties[| properties_i]
					
					states += prefix_properties+string(current_property[? "name"])+"="+string(current_property[? "payload"])
					
					//Adds a comma if there's more than one state
					prefix_properties = ","
					properties_i++
					}
				}
				
			#endregion
				
			block = string(states + "|" + block_id)
			
			#endregion
		
			if block != -1 {
				
			if is_string(block) block = split_string(block, "|")
			
			//Coords for .obj	
			var bl_off_x = block_x + chunk_exp_x //Offset the X coordinate
			var bl_off_z = block_z + chunk_exp_z //Offset the Z coordinate
			var bl_off_y = block_y + (section_y*16) //Offset Y by the section Y
			
			
			//Cullfaces
			
			
			cullfaces[? "north"] = region_block_is_transparent(block_x, block_y, block_z-1, blockstates, index_size, i_air, palette)
			cullfaces[? "east"] = region_block_is_transparent(block_x+1, block_y, block_z, blockstates, index_size, i_air, palette)
			cullfaces[? "south"] = region_block_is_transparent(block_x, block_y, block_z+1, blockstates, index_size, i_air, palette)
			cullfaces[? "west"] = region_block_is_transparent(block_x-1, block_y, block_z, blockstates, index_size, i_air, palette)
			cullfaces[? "up"] = region_block_is_transparent(block_x, block_y+1, block_z, blockstates, index_size, i_air, palette)
			cullfaces[? "down"] = region_block_is_transparent(block_x, block_y-1, block_z, blockstates, index_size, i_air, palette)
			
			//Create block .obj
			mc2obj_state(bl_off_x,bl_off_y,bl_off_z,block[1],block[0],obj,vertice_count,vertice_texture_count,cullfaces,mtl,mtl_index)
			
			}
			
			}
			
			block_y++
				if block_y = 16 {
					block_y = 0
					block_z++
					}
					
				if block_z = 16 {
					block_z = 0
					block_x++
					}
					
				if block_x = 16 {
					block_x = "done"
					}

					
			} until block_x = "done"
			}
			
			i++
			debug_log("INFO", "section done" + string(section_y))
		
		}