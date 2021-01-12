///write_tag_byte(buffer, number)
///@param buffer
///@param number
function write_tag_int(argument0, argument1) {
	var buffer = argument0
	var number = argument1
	var tbuff = buffer_create(1, buffer_grow, 1)

	buffer_write(tbuff, buffer_s32, number)
	buffer_seek(tbuff, buffer_seek_start, 0)
	var bytes = reverse_byte_order(tbuff, 4)


	buffer_write(buffer, buffer_s32, buffer_read(bytes, buffer_s32))


	buffer_delete(tbuff)
	buffer_delete(bytes)


}
