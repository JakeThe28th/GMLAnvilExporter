///read_tag_string(buff)
///@param buff
function read_tag_int_array(buffer, tag_ds) {
	var ds = ds_list_create()

	var length = read_tag_int(buffer)
	//Get big endian short short 'length'

	var i = 0
	repeat length {
		var temp = read_tag_int(buffer)
		ds[| i] = temp
	
		i++
		}
	//Write 'length' bytes from the file's buffer into array
	

	ds_map_add_list(tag_ds, "payload", ds)
	ds_map_add(tag_ds, "length", length)
	//Add payload and length to the tag's DS map.

	//return tag_ds
}
