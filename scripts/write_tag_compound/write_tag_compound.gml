///write_tag_compound(ds_listp, buffer)
///@param ds_list
///@param buffer
function write_tag_compound(argument0, argument1) {
	var ds_list = argument0
	var buffer = argument1

	var i = 0
	repeat ds_list_size(ds_list) {
		var current_entry = ds_list_find_value(ds_list, i)
			var current_name_length = ds_map_find_value(current_entry, "name_length")
			var current_name = ds_map_find_value(current_entry, "name")
			var current_type = ds_map_find_value(current_entry, "type")
			var current_payload = ds_map_find_value(current_entry, "payload")
		
			write_tag_byte(buffer, current_type)
			write_tag_string(buffer, current_name, current_name_length)
		
		switch (current_type) {
			case 0: debug_log("NBT: Tag end"); break;
			case 1: write_tag_byte(buffer, current_payload); break;
			case 2: write_tag_short(buffer, current_payload); break;
			case 3: write_tag_int(buffer, current_payload); break;
			case 4: write_tag_long(buffer, current_payload); break;
			case 5: write_tag_float(buffer, current_payload); break;
			case 6: write_tag_double(buffer, current_payload); break;
			case 7: write_tag_byte_array(buffer, ds_map_find_value(current_payload, "payload"), ds_map_find_value(current_payload, "length")); break;
			case 8: write_tag_string(buffer, ds_map_find_value(current_payload, "payload"), ds_map_find_value(current_payload, "length")); break;
		
			case 9: 
			var list_type = ds_map_find_value(current_entry, "list_type")
			var list_length = ds_map_find_value(current_entry, "list_length")
				write_tag_byte(buffer, list_type)
				write_tag_int(buffer, list_length)
			
			write_tag_list(current_payload, buffer, list_type); 
			break;
		
			case 10: write_tag_compound(current_payload, buffer); break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}
	
	
		i++
		}

	write_tag_byte(buffer, 0)


}
