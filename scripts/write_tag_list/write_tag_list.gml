///write_tag_list(ds_list, buffer, list_type)
///@param ds_list
///@param buffer
///@param list_type
function write_tag_list(argument0, argument1, argument2) {
	var ds_list = argument0
	var buffer = argument1
	var list_type = argument2


	var i = 0
	repeat ds_list_size(ds_list) {
		var current_entry = ds_list_find_value(ds_list, i)
			var current_payload = current_entry


		switch (list_type) {
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
		
			case 10: write_tag_compound(current_entry, buffer); break;
		
			default: debug_log("NBT: Unknown tag. "); break;
			}
	
	
		i++
		}


}
