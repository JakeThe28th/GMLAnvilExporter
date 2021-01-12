///write_tag_byte(buffer, number)
///@param buffer
///@param number
function write_tag_byte(argument0, argument1) {
	var buffer = argument0
	var number = argument1

	buffer_write(buffer, buffer_s8, number)


}
