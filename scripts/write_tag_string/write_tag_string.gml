///write_tag_string(buffer, name, name_length)
///@param buffer
///@param string
///@param string_length
function write_tag_string(argument0, argument1, argument2) {
	var buffer = argument0
	var nbt_string = argument1
	var nbt_string_length = argument2

	write_tag_short(buffer, nbt_string_length)
	buffer_write(buffer, buffer_text, nbt_string)


}
