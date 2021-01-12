function region_place_block(b_x, b_y, b_z, region) {
	
	//Chunk coordinates
	var chunk_coord_x = floor(b_x / 16);
	var chunk_coord_z = floor(b_z / 16);
	
	var chunk_filename = nbt_save_dir + string(chunk_coord_x)+","+string(chunk_coord_z)+".mcc"
	
	//If chunk isn't already opened, open it.
	if !file_exists(chunk_filename) {
		if region_open_chunk(b_x, b_y, b_z, region) < 0 return -1
		//-1 = no mca
		//-2 = no chunk
		//-3 = no section
		//-4 = no block
		}
		
	var chunk = nbt_start(chunk_filename)
	
	var section_list = nbt_path(chunk, ";", "Level;Sections", 1)[? "payload"]
	
	var section_y = floor(b_y / 16)
	
	//Get the section's  compound tag.
	var i = 0
	do  {
		//If 'i' is bigger than the size of the section list, return -3 (no section)
		if i >= ds_list_size(section_list) return -3
		
		//Set temp to the entry 'i' of the section list.
		//Then loop through it's entries for the 'Y' tag.
		temp = section_list[| i]
		var temp_i = 0
		do  {
			temp_i++
			} until ds_map_find_value(temp[| temp_i], "name") = "Y"
		
		i++
		} until ds_map_find_value(temp[| temp_i], "payload") = section_y
		
	var section = section_list[| i-1]
	
	
	var palette = nbt_path(section,";","Palette", 0)[? "payload"]
	var temp = undefined
	var i = 0
	do {
		
		//READ PALLETE, ADD BLOCKS
		
		} until temp = "minecraft:stone" or i >= ds_list_size(palette)
	
	if temp = undefined { 
		//add to pallete 
		}
		
//	temp = nbt_path(section,";","Palette")
	
	var i = 0
	var temp = 0
	//do { } until util_ds_path(chunk, ";", "paylod,0,payload", "both")
	
	//Later, make it not open the region file and close it per chunk.
	

}
