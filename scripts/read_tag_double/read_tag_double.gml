///read_tag_string(buff)
///@param buff
function read_tag_double(argument0) {
	var buffer = argument0

	var buffer_new = reverse_byte_order(buffer, 8)
	var return_value = buffer_read(buffer_new, buffer_f64)
	//Swap byte order, then read from buffer.

	buffer_delete(buffer_new)
	return return_value


}
