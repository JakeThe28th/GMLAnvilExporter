///read_tag_string(buff)
///@param buff
function read_tag_long(argument0) {
	var buffer = argument0

	var buffer_new = reverse_byte_order(buffer, 8)
	var return_value = buffer_read(buffer_new, buffer_u64)
	//Swap byte order, then read from buffer. (Check the difference between signed and unsigned later please! -Jake)

	buffer_delete(buffer_new)
	return return_value


}
