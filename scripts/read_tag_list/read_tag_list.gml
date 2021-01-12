///tag_list(buffer, ds_map, type, length)
///@param buffer
///@param ds_map
///@param tag_type
///@param length
function read_tag_list(argument0, argument1, argument2, argument3) {
	var buffer = argument0
	var ds_list = argument1
	var tag_type = argument2
	var length = argument3

	repeat length {
		var payload = "none"


		switch (tag_type) {
			case 0: debug_log("NBT: Tag end"); break;
			case 1: payload = read_tag_byte(buffer); ds_list_add(ds_list, payload); break;
			case 2: payload = read_tag_short(buffer); ds_list_add(ds_list, payload); break;
			case 3: payload = read_tag_int(buffer); ds_list_add(ds_list, payload); break;
			case 4: payload = read_tag_long(buffer); ds_list_add(ds_list, payload); break;
			case 5: payload = read_tag_float(buffer); ds_list_add(ds_list, payload); break;
			case 6: payload = read_tag_double(buffer); ds_list_add(ds_list, payload); break;
			case 7: payload = read_tag_byte_array(buffer); ds_list_add(ds_list, payload); ds_list_mark_as_map(ds_list, ds_list_size(ds_list)-1); break;
			case 8: payload = read_tag_string(buffer); ds_list_add(ds_list, payload); ds_list_mark_as_map(ds_list, ds_list_size(ds_list)-1); break;
		
			case 9: 
		#region List tag
			payload = ds_list_create(); 
			var l_type = read_tag_byte(buffer); 
			var l_length = read_tag_int(buffer);
			read_tag_list(buffer, payload, l_type, l_length); 
			ds_list_add(ds_list, "list_type", l_type); 
			ds_list_add(ds_list, "list_length", l_length); 
			ds_list_add(ds_list, payload); 
			ds_list_mark_as_list(ds_list, ds_list_size(ds_list)-1);
		#endregion
			break;
		
			case 10: payload = ds_list_create();
		#region Compound tag
			read_tag_compound(buffer, payload); 
			ds_list_add(ds_list, payload);
			ds_list_mark_as_list(ds_list, ds_list_size(ds_list)-1);
		#endregion
			break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}
		}


}
