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
	
	//Get chunk
	//Get sections
	//repeat for every section:
		//read blocks using pallete
		//pass block info into mc2obj functions
		
		
	//Step 3:
	//NEED TO HANDLE: Variable INT lengths.
	//Read wiki stuff.
	
	//Get the amount of bits required to store the biggest index into the pallete
	//Clamp it up into AT LEAST 4
	//If it's a factor of 64, segment the value into bytes and half bytes, and read. 
	//Factors of 64: 1, 2, 4, 8, 16, 32, 64.
	//If it's not, clamp it UP into factors of 64.
	//EG if it's 4 bits, read a half byte
	//If it's 12 bits, that's 8 + 4 bits, so a byte an a half. However, it isn't a factor of 64, so clamp it up to 2 bytes, and ignore some.
	
	//" If the size of each index is not a factor of 64, the highest bits where no block index fits anymore are unused. "
	
	//also keep in mind:
	//"Since Java Edition uses big-endian, indices inside one long are in reverse order, but the longs themselves are normally ordered. 
	//In versions prior to 1.16, the full range of bits is used, where the remaining bits of a block index continue on the next long value."
	
	//My idea:
	//Compress the longs into a single buffer, and reorder them to be correct. Then read the indexes from the buffer, using the clamps.
	
	//Once i do this, i'll also have to rework my blockstate exporter to work at all, but i'll first check if i'm getting blocks
	//correctly.
	
	//Use tumble music
	//Pack support
	
	
	
	//CODE ----------------------------------------
	
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
			
			region_section_get_block(block_x, block_y, block_z, chunk_exp_x, chunk_exp_z, current_section)
			
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
	
	
	
	//nbt_path(chunk, ";", "Leve
}