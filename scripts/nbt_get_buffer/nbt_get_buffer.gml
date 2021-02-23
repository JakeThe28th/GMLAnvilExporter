// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function nbt_get_buffer(buffer, seperator, path, i) {
	//This script requires util_split_string
	
	if buffer = undefined return -1
	var path_split = split_string(path, seperator)
	
	//buffer_seek(buffer, buffer_seek_start, 0)
	
	//var tag_type = buffer_read(buffer, buffer_s8)
	//	if tag_type !=10 return -10
	
	//buffer_seek(buffer, buffer_seek_start, 0)
	
	do {
		var tag_type = buffer_read(buffer, buffer_s8)
		if tag_type = 0 break
		//Exit if tag is tag_end.
	
		var payload = "none"
	
	#region Create a DS map for this tag.
		var tag_ds = ds_map_create()
			//ds_list_add(ds_list, tag_ds)
			//ds_list_mark_as_map(ds_list, ds_list_size(ds_list)-1)
			//Create a DS map for this tag.
		#endregion
	#region Get the tag's name
			var name_ds = ds_map_create()
			read_tag_string(buffer, name_ds) //Get  the name's DS map
		
			var tag_name = ds_map_find_value(name_ds, "payload")
			var tag_name_length = ds_map_find_value(name_ds, "length")
			//Get this tag's name and name length.
		#endregion
	#region Add Named tag attributes to DS map.
			ds_map_add(tag_ds, "type", tag_type)
			ds_map_add(tag_ds, "name", tag_name)
			ds_map_add(tag_ds, "name_length", tag_name_length)
		#endregion
		
		if tag_name = path_split[i] { 


		switch (tag_type) {
			case 0: debug_log("NBT", "NBT: Tag end"); break;
			case 1: payload = read_tag_byte(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 2: payload = read_tag_short(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 3: payload = read_tag_int(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 4: payload = read_tag_long(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 5: payload = read_tag_float(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 6: payload = read_tag_double(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 7: read_tag_byte_array(buffer, tag_ds); break;
			case 8: read_tag_string(buffer, tag_ds); break;
		
			case 11: read_tag_int_array(buffer, tag_ds); break;
			case 12: read_tag_long_array(buffer, tag_ds); break;
			
					case 9: 
		#region List tag
			payload = ds_list_create(); 
			var l_type = read_tag_byte(buffer); 
			var l_length = read_tag_int(buffer);
			read_tag_list(buffer, payload, l_type, l_length); 
			ds_map_add(tag_ds, "list_type", l_type); 
			ds_map_add(tag_ds, "list_length", l_length); 
			ds_map_add_list(tag_ds, "payload", payload); 
		#endregion
			break;
		
			case 10: 
			if i = array_length(path_split) return buffer_tell(buffer) else {
				tag_ds = nbt_get_buffer(buffer, seperator, path, i+1)
				var temp = "b"
				}
				
			break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}	
		} else {

		switch (tag_type) {
			case 0: debug_log("NBT", "NBT: Tag end"); break;
			case 1: buffer_seek(buffer, buffer_seek_relative, 1); break; //Tag byte
			case 2: buffer_seek(buffer, buffer_seek_relative, 2); break; //Tag short
			case 3: buffer_seek(buffer, buffer_seek_relative, 4); break; //Tag int
			case 4: buffer_seek(buffer, buffer_seek_relative, 8); break; //Tag long
			case 5: buffer_seek(buffer, buffer_seek_relative, 4); break; //Tag float
			case 6: buffer_seek(buffer, buffer_seek_relative, 8); break; //Tag double
			
			case 7: var length = read_tag_int(buffer); //Tag byte array
				buffer_seek(buffer, buffer_seek_relative, length); 
				break;
			case 8: var length = read_tag_short(buffer); //Tag string
				buffer_seek(buffer, buffer_seek_relative, length); 
				break;
		
			case 11: var length = read_tag_int(buffer); //Tag int array
				buffer_seek(buffer, buffer_seek_relative, length*4); 
				break;
			case 12: var length = read_tag_int(buffer); //Tag long array
				buffer_seek(buffer, buffer_seek_relative, length*8); 
				break;
			
					case 9: 
		#region List tag
			var l_type = read_tag_byte(buffer); 
			var l_length = read_tag_int(buffer);
			if l_length > 0 read_tag_list_deadend(buffer, l_type, l_length)
		#endregion
			break;
		
			case 10: 
				read_tag_compound_deadend(buffer)
				break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}	
			
		}
		
		
		} until tag_type = 0 or tag_name = path_split[i]
		
		if tag_type = 0 return -100
		if tag_ds > -1 return tag_ds else return -1
}




function read_tag_compound_deadend(buffer) {
	//This script requires util_split_string
	
	if buffer = undefined return -1
	
	//buffer_seek(buffer, buffer_seek_start, 0)
	
	//var tag_type = buffer_read(buffer, buffer_s8)
	//	if tag_type !=10 return -10
	
	//buffer_seek(buffer, buffer_seek_start, 0)
	
	do {
		var tag_type = buffer_read(buffer, buffer_s8)
		if tag_type = 0 break
		//Exit if tag is tag_end.
	
		var payload = "none"
	
	#region Get the tag's name
			var name_ds = ds_map_create()
			read_tag_string(buffer, name_ds) //Get  the name's DS map
		
			ds_map_destroy(name_ds)
		#endregion

		switch (tag_type) {
			case 0: debug_log("NBT", "NBT: Tag end"); break;
			case 1: buffer_seek(buffer, buffer_seek_relative, 1); break; //Tag byte
			case 2: buffer_seek(buffer, buffer_seek_relative, 2); break; //Tag short
			case 3: buffer_seek(buffer, buffer_seek_relative, 4); break; //Tag int
			case 4: buffer_seek(buffer, buffer_seek_relative, 8); break; //Tag long
			case 5: buffer_seek(buffer, buffer_seek_relative, 4); break; //Tag float
			case 6: buffer_seek(buffer, buffer_seek_relative, 8); break; //Tag double
			
			case 7: var length = read_tag_int(buffer); //Tag byte array
				buffer_seek(buffer, buffer_seek_relative, length); 
				break;
			case 8: var length = read_tag_short(buffer); //Tag string
				buffer_seek(buffer, buffer_seek_relative, length); 
				break;
		
			case 11: var length = read_tag_int(buffer); //Tag int array
				buffer_seek(buffer, buffer_seek_relative, length*4); 
				break;
			case 12: var length = read_tag_int(buffer); //Tag long array
				buffer_seek(buffer, buffer_seek_relative, length*8); 
				break;
			
					case 9: 
		#region List tag
			var l_type = read_tag_byte(buffer); 
			var l_length = read_tag_int(buffer);
			if l_length > 0 read_tag_list_deadend(buffer, l_type, l_length)
		#endregion
			break;
		
			case 10: 
				read_tag_compound_deadend(buffer)
				break;
				
			break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}
		
		} until tag_type = 0
}


function read_tag_list_deadend(buffer, tag_type, lengthL) {

	repeat lengthL {
		switch (tag_type) {
			case 0: debug_log("NBT", "NBT: Tag end"); break;
			case 1: buffer_seek(buffer, buffer_seek_relative, 1); break; //Tag byte
			case 2: buffer_seek(buffer, buffer_seek_relative, 2); break; //Tag short
			case 3: buffer_seek(buffer, buffer_seek_relative, 4); break; //Tag int
			case 4: buffer_seek(buffer, buffer_seek_relative, 8); break; //Tag long
			case 5: buffer_seek(buffer, buffer_seek_relative, 4); break; //Tag float
			case 6: buffer_seek(buffer, buffer_seek_relative, 8); break; //Tag double
			
			case 7: var length = read_tag_int(buffer); //Tag byte array
				buffer_seek(buffer, buffer_seek_relative, length); 
				break;
			case 8: var length = read_tag_short(buffer); //Tag string
				buffer_seek(buffer, buffer_seek_relative, length); 
				break;
		
			case 11: var length = read_tag_int(buffer); //Tag int array
				buffer_seek(buffer, buffer_seek_relative, length*4); 
				break;
			case 12: var length = read_tag_int(buffer); //Tag long array
				buffer_seek(buffer, buffer_seek_relative, length*8); 
				break;
			
					case 9: 
		#region List tag
			var l_type = read_tag_byte(buffer); 
			var l_length = read_tag_int(buffer);
			if l_length > 0 read_tag_list_deadend(buffer, l_type, l_length)
		#endregion
			break;
		
			case 10: 
				read_tag_compound_deadend(buffer)
				break;
				
			break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}
		}


}
