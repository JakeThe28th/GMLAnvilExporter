// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function nbt_path(ds, seperator, path, start_type) {
	//This script requires util_split_string
	//types: map_only, list_only, both
	
	if ds = undefined return -1
	path = split_string(path, seperator)
	
	var i = 0
	var name_temp;
	repeat array_length(path) {	
		var name_i = 0
		//start type: 0 = list, 1 = map
		if start_type { 
			ds = ds[? "payload"]
			}
		
		do {
			name_temp = ds_map_find_value(ds[| name_i], "name")
			
			name_i++
			} until name_temp = path[i] or name_i >= ds_list_size(ds)
		
		name_i-=1
			
		if name_i >= ds_list_size(ds) return -1
		if name_temp != path[i] return -1
		
		ds = ds[| name_i]
		start_type = true
		
		i++
		}
		return ds
}