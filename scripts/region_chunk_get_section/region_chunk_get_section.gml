// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function region_chunk_get_section(sY, chunk){
	//Find the section in the chunk using Y.
	//Return section DS
	
	var sections = nbt_path(chunk, ";", "Level;Sections",1)[? "payload"]
	var i = 0
	
	repeat ds_list_size(sections) {
		
		var section_temp = sections[| i]
		var sY_map = nbt_path(section_temp, ";", "Y", 0)
		
		if sY_map[? "payload"] = sY return section_temp
		
		i++
		}
	
	//error rEAD
}