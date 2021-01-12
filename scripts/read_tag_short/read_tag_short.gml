///read_tag_string(buff)
///@param buff
function read_tag_short(argument0) {
	var buffer = argument0

	var buffer_new = reverse_byte_order(buffer, 2)
	var return_value = buffer_read(buffer_new, buffer_s16)
	//Swap byte order, then read from buffer.

	buffer_delete(buffer_new)
	return return_value


}
