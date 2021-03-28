progress = 0
todo = 256

section_list = -1

i = 0

cullfaces = ds_map_create()

//function region_export_chunk(chunk_x, chunk_z, chunk_exp_x, chunk_exp_z, resources_dir, region, obj, mtl) {
	chunk_x = x
	chunk_z = y
	chunk_exp_x = x*16
	chunk_exp_z = y*16
	
	resources_dir = working_directory + "OR"
	
	obj = obj_main.obj
	
	mtl = obj_main.mtl
	
	mtl_index = obj_main.mtl_index 
	
	
	//Open region if needed
		if obj_main.ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = undefined {
			region = buffer_load(global.save_folder + "region\\r." + string(floor(chunk_x / 32))+"."+ string(floor(chunk_z / 32)) + ".mca")
			obj_main.ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = region
			}
			
	region = obj_main.ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))]
	
	
	
	
	chunk_filename = nbt_save_dir + string(chunk_x)+","+string(chunk_z)+".mcc"
	
	//If chunk isn't already opened, open it.
	a = 1
	if !file_exists(chunk_filename) {
		a = 8
		a = region_open_chunk(chunk_x, chunk_z, region)// < 0 return -1
		//-1 = no mca
		//-2 = no chunk
		//-3 = no section
		//-4 = no block
		}
		
	if a < 0 {
		
		//instance_create_depth(x, y, depth, obj_export_chunk_1_16)
		obj_main.chunks[? string(x) + ";" + string(y)] = 1
		instance_destroy()
		
		}
		
	chunk = nbt_start(chunk_filename)
	
	section_list = nbt_path(chunk, ";", "Level;Sections", 1)[? "payload"]
	
	
	//Get the section Y, for offsetting Y coords.
	section_y = 0 
	
	//Relative to chunk section block coords
	block_x = 0
	block_y = 0
	block_z = 0
	
	
	//Coords for .obj
	//Offset relative coords by the export offset (Offset, but close to mesh origin.)
	bl_off_x = block_x + chunk_exp_x
	block_ex_z = block_z + chunk_exp_z
	
	//Offset Y by section
	bl_off_y = block_y + section_y*16
	
	
	startOFLoop = true 
	
	obj_main.totalBlocksToDo += ds_list_size(section_list)*(16*16*16)