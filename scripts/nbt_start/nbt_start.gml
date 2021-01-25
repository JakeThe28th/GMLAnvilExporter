///nbt_start(file_path)
///@param file_path
function nbt_start(argument0) {
	var file_path = argument0
	lib_gz()

	var buff = buffer_load(file_path)
	var nbt_ds = ds_map_create()
		buffer_seek(buff, buffer_seek_start, 0)
		debug_log("NBT", "NBT: Starting to read NBT File: '" + string(file_path) + "'")
		//Load the file into a buffer, create a ds map for the result, then go to the start of the buffer.


	var tag_type = buffer_read(buff, buffer_s8) //Get type
	var tag_payload = ds_list_create() //Create compound payload list

	if tag_type != 10 {
		gzunzip(file_path, working_directory + "gzunzip")
		var i = current_second
		do { 
			if current_second > i + 5 show_error("Took too long. exiting.", true)
			} until file_exists(working_directory + "gzunzip")
		var buff = buffer_load(working_directory + "gzunzip")
		buffer_seek(buff, buffer_seek_start, 0)
	
		var tag_type = buffer_read(buff, buffer_s8) //Get type
		if tag_type != 10 show_error("Can't read NBT data.", true)
		}
	



#region Get tag name
		var name_ds = ds_map_create()
		read_tag_string(buff, name_ds) //Get  the name's DS map
		
		var tag_name = ds_map_find_value(name_ds, "payload") //Get the name
		var tag_name_length = ds_map_find_value(name_ds, "length") //Get the name's length
	#endregion
#region Add Named tag attributes to DS
		ds_map_add(nbt_ds, "type", tag_type)
		ds_map_add(nbt_ds, "name", tag_name)
		ds_map_add(nbt_ds, "name_length", tag_name_length)
		ds_map_add_list(nbt_ds, "payload", tag_payload)
		//Add values to DS map
	#endregion

	read_tag_compound(buff, tag_payload)

	debug_log("NBT", "NBT: Finished reading NBT file. DS map result: '" + string(nbt_ds) + "'")

	return nbt_ds
	a = "b"
	a = a = "c"


}
