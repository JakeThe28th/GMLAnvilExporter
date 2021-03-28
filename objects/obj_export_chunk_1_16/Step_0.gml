	if i < ds_list_size(section_list) {
			
		if startOFLoop {
		//repeat ds_list_size(section_list) {
			
		current_section = section_list[| i]
		
		section_y = nbt_path(current_section, ";","Y",0)[? "payload"]
		
		//buffer_write(obj, buffer_text,"o Section_"+string(section_y))
		//buffer_write(obj, buffer_text, chr($000D) + chr($000A))
		

		#region Relative to chunk section block coords
		block_x = 0
		block_y = 0
		block_z = 0
		
		#endregion
		
		//Get block data DS and Palette DS.
		blockstates = nbt_path(current_section, ";","BlockStates",0)
		palette = nbt_path(current_section, ";","Palette",0)
		
	//if section_y < 4 blockstates = -1
		
	if blockstates >= 0 and palette >= 0 {
		blockstates = blockstates[? "payload"]
		palette = palette[? "payload"]
			
		//Get the number of bits required to store the highest palette index. 
		//If it's less than 4 bits, clamp it to 4 bits, since that's the minimum.
		index_size = clamp(ceil(log2(ds_list_size(palette)) / log2(2)), 4, 512)
		
		temp = undefined
		i_air = 0
		
		
		
		do {
			
			temp = nbt_path(palette[| i_air],";","Name",0)[? "payload"]
		
			i_air++
			} until string_pos("air", temp) > 0 or i_air >= ds_list_size(palette)
			
			i_air--
			
		} else {
			i++
			debug_log("INFO", "section done" + string(section_y))
			
			return -5
			
			}
		
		startOFLoop = 0
		}
		
		//Loop through blocks.
		var time_per_step = ((1/2)*1000)/obj_main.export_chunk_count
		var timer = current_time + time_per_step
		
		repeat 1000 {
			
			#region Get the states|block_id	

			//Use script to get palette index.
			block = region_blockstates_get_index(block_x, block_y, block_z, blockstates, index_size)
			
			if block != i_air {
			
				if palette[| block] = undefined then debug_log("Error", "Pallete index undefined")
				


			//Get the block id, and create a variable for blockstates
			states = ""
			block_id = nbt_path(palette[| block],";","Name",0)[? "payload"]
			
			//Get the properties DS
			block_properties = nbt_path(palette[| block],";","Properties",0)
			
				
		#region Repeat through properties, add to string.
		if block_properties > -1 {
			properties_i = 0
			block_properties = block_properties[? "payload"]
			prefix_properties = ""
					
				//Loop
				repeat ds_list_size(block_properties) {
					current_property = block_properties[| properties_i]
					
					states += prefix_properties+string(current_property[? "name"])+"="+string(current_property[? "payload"])
					
					//Adds a comma if there's more than one state
					prefix_properties = ","
					properties_i++
					}
				}
				
			#endregion
				
			//block = string(states + "|" + block_id)
			block = array_create(2, -1)
			block[0] = states
			block[1] = block_id
			
			#endregion
		
			//	if block != -1 {
				
			//if is_string(block) block = split_string(block, "|")
			
			//Coords for .obj	
			bl_off_x = block_x + chunk_exp_x //Offset the X coordinate
			bl_off_z = block_z + chunk_exp_z //Offset the Z coordinate
			bl_off_y = block_y + (section_y*16) //Offset Y by the section Y
			
			
			//Cullfaces
			
			
			cullfaces[? "north"] = region_block_is_transparent(block_x, block_y, block_z-1, blockstates, index_size, i_air, palette)
			cullfaces[? "east"] = region_block_is_transparent(block_x+1, block_y, block_z, blockstates, index_size, i_air, palette)
			cullfaces[? "south"] = region_block_is_transparent(block_x, block_y, block_z+1, blockstates, index_size, i_air, palette)
			cullfaces[? "west"] = region_block_is_transparent(block_x-1, block_y, block_z, blockstates, index_size, i_air, palette)
			cullfaces[? "up"] = region_block_is_transparent(block_x, block_y+1, block_z, blockstates, index_size, i_air, palette)
			cullfaces[? "down"] = region_block_is_transparent(block_x, block_y-1, block_z, blockstates, index_size, i_air, palette)
			
			//Create block .obj
			mc2obj_state(bl_off_x,bl_off_y,bl_off_z,block[1],block[0],obj,obj_main.vertice_count,obj_main.vertice_texture_count,cullfaces,mtl,mtl_index)
			
			//}
			
			}
			
			obj_main.totalBlocksDone += 1
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

					
			if block_x = "done" {
				startOFLoop = true
				i++
				debug_log("INFO", "section done" + string(section_y))
			}
			
			if current_time > timer or block_x = "done" break;
		}
			
		} else {
			obj_main.chunks[? string(x) + ";" + string(y)] = 1
			obj_main.export_chunk_count-=1
			instance_destroy()
				}
		
		//}

//}