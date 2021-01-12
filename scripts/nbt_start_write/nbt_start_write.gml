///nbt_start_write(ds_map)
///@param ds_map
function nbt_start_write(argument0) {
	var ds_map = argument0
	var buff = buffer_create(1, buffer_grow, 1)
	buffer_seek(buff, buffer_seek_start, 0)

	//var name_length = ds_map_find_value(ds_map, "name_length")
	//var name = ds_map_find_value(ds_map, "name")
	//var type = ds_map_find_value(ds_map, "type")
	//var payload = ds_map_find_value(ds_map, "payload")

	//write_tag_byte(buff, type)
	//write_tag_string(buff, name, name_length)
	//Write root compound's name and type.

	var ds_list = ds_list_create()
	ds_list_add(ds_list, ds_map)
	ds_list_mark_as_map(ds_list, ds_list_size(ds_list)-1)

	write_tag_compound(ds_list, buff)

	return buff


}
