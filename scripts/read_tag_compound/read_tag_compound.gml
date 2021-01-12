///tag_compound(buffer, ds_map)
///@param buffer
///@param ds_map
function read_tag_compound(argument0, argument1) {
	var buffer = argument0
	var ds_list = argument1

	do {
		var tag_type = buffer_read(buffer, buffer_s8)
		if tag_type = 0 break
		//Exit if tag is tag_end.
	
		var payload = "none"
	
	#region Create a DS map for this tag.
		var tag_ds = ds_map_create()
			ds_list_add(ds_list, tag_ds)
			ds_list_mark_as_map(ds_list, ds_list_size(ds_list)-1)
			//Create a DS map for this tag.
		#endregion
	#region Get the tag's name
		var name_ds = read_tag_string(buffer) 
			var tag_name = ds_map_find_value(name_ds, "payload")
			var tag_name_length = ds_map_find_value(name_ds, "length")
			//Get this tag's name and name length.
		#endregion
	#region Add Named tag attributes to DS map.
			ds_map_add(tag_ds, "type", tag_type)
			ds_map_add(tag_ds, "name", tag_name)
			ds_map_add(tag_ds, "name_length", tag_name_length)
		#endregion


		switch (tag_type) {
			case 0: debug_log("NBT: Tag end"); break;
			case 1: payload = read_tag_byte(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 2: payload = read_tag_short(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 3: payload = read_tag_int(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 4: payload = read_tag_long(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 5: payload = read_tag_float(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 6: payload = read_tag_double(buffer); ds_map_add(tag_ds, "payload", payload); break;
			case 7: payload = read_tag_byte_array(buffer, tag_ds); break;
			case 8: payload = read_tag_string(buffer); ds_map_add_map(tag_ds, "payload", payload); break;
		
			case 11: payload = read_tag_int_array(buffer, tag_ds); break;
			case 12: payload = read_tag_long_array(buffer, tag_ds); break;
			
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
		
			case 10: payload = ds_list_create();
		#region Compound tag
			read_tag_compound(buffer, payload); 
			ds_map_add_list(tag_ds, "payload", payload);
		#endregion
			break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}
		
		} until tag_type = 0


}
