///write_tag_byte(buffer, array, length)
///@param buffer
///@param array
///@param length
function write_tag_byte_array(argument0, argument1, argument2) {
	var buffer = argument0
	var array = argument1
	var length = argument2

	write_tag_int(buffer, length)

	var i = 0
	repeat length {
		write_tag_byte(buffer, array[| i])
		}


}
