///reverse_byte_order(buffer, bytecount)
///@param buffer
///@param bytecount
function reverse_byte_order(argument0, argument1) {
	var buff = argument0
	var count = argument1

	var tbuff = buffer_create(count, buffer_fixed, 1)
	var array = array_create(1, 0)
	var i;

	//Get values, index in array.
	buffer_seek(tbuff, buffer_seek_start, 0)
	for (i = 0; i < count; i++) {
		array[i] = buffer_read(buff, buffer_s8)
		}
	
	//Write values from array into new buffer, in reverse order.
	for (i = count; i > 0 ; i--) {
		buffer_write(tbuff, buffer_s8, array[i-1])
		}
	
	//Reset the seek and send it off!
	buffer_seek(tbuff, buffer_seek_start, 0)
	return tbuff
	//Remember to delete the buffer once you get the returned values!


}
