function region_export_chunk(chunk_x, chunk_z, chunk_exp_x, chunk_exp_z, resources_dir, region, obj, mtl) {
	
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
		
		do {
			
			//Get the states|block_id
			var block = region_section_get_block(block_x, block_y, block_z, current_section)
			if block != -1 {
				
			if is_string(block) block = split_string(block, "|")
			
			//Coords for .obj	
			var bl_off_x = block_x + chunk_exp_x //Offset the X coordinate
			var bl_off_z = block_z + chunk_exp_z //Offset the Z coordinate
			var bl_off_y = block_y + (section_y*16) //Offset Y by the section Y
			
			//Create block .obj
			mc2obj_state(bl_off_x,bl_off_y,bl_off_z,block[1],block[0],obj,vertice_count,vertice_texture_count,cullfaces,mtl,mtl_index)
			
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
			
			i++
			debug_log("INFO", "section done" + string(section_y))
		
		}

}