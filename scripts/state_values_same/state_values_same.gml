// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function state_values_same(val1, val2) {
	var array1 = split_string(val1, ",")
	var array2 = split_string(val2, ",")

	var statemap1 = ds_map_create()
	var statemap2 = ds_map_create()
	
	var arri = 0
	repeat array_length(array1) {
		var temp = split_string(array1[arri], "=")
		
		ds_map_add(statemap1, temp[0], temp[1])
		
		arri++
		}
		
	var arri = 0
	repeat array_length(array2) {
		var temp = split_string(array2[arri], "=")
		
		ds_map_add(statemap2, temp[0], temp[1])
		
		arri++
		}
		
	arri = 0
	var valtemp = ds_map_find_first(statemap1)
	repeat ds_map_size(statemap1) {
		
		if ds_map_find_value(statemap1, valtemp) != ds_map_find_value(statemap2, valtemp) return -2
		
		
		valtemp = ds_map_find_next(statemap1, valtemp)
		}
		
		
		return true
}