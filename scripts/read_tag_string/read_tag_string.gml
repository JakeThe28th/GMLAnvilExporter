///read_tag_string(buff)
///@param buff
function read_tag_string(argument0) {
	var buffer = argument0


	var length = read_tag_short(buffer)
	var tbuff = buffer_create(1, buffer_grow, 1)
	//Get big endian short short 'length'


	repeat length {
		var temp = buffer_read(buffer, buffer_s8)
		buffer_write(tbuff, buffer_s8, temp)
		}
	//Write 'length' bytes from the file's buffer into buffer 'tbuff'
	
	buffer_seek(tbuff, buffer_seek_start, 0)

	var return_ds = ds_map_create()
	ds_map_add(return_ds, "payload", buffer_read(tbuff, buffer_text))
	ds_map_add(return_ds, "length", length)
	//Add payload and length to the return DS map.

	buffer_delete(tbuff)

	return return_ds
	//Go to the beginning of 'tbuff' and read as text! Need to put text in new buffer due to
	//there being no null character at the end.


}
