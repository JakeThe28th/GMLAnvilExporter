// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function region_block_is_transparent(block_x, block_y, block_z, blockstates, ind_size, air, palette) {
	
	if block_x < 0  || block_y < 0 || block_z < 0 || block_x > chunk_size-1 || block_y > chunk_size-1 || block_z > chunk_size-1 return 1
	var temp = region_blockstates_get_index(block_x, block_y, block_z, blockstates, ind_size)
	
	if temp = air return 1
	
	temp = palette[| temp]
	
	
	//switch (temp) {
	//	case "minecraft:air": break;
		
		//}
		
	if string_pos("air",temp) > 1 return 1
	if string_pos("string",temp) > 1 return 1
	if string_pos("leave",temp) > 1 return 1
	if string_pos("glass",temp) > 1 return 1
	if string_pos("stair",temp) > 1 return 1
	if string_pos("water",temp) > 1 return 1
	if string_pos("lava",temp) > 1 return 1
	if string_pos("chest",temp) > 1 return 1
	if string_pos("shulker",temp) > 1 return 1
	if string_pos("banner",temp) > 1 return 1
	if string_pos("slab",temp) > 1 return 1
	if string_pos("flower",temp) > 1 return 1
	if string_pos("cornflower",temp) > 1 return 1
	if string_pos("blue_orchid",temp) > 1 return 1
	if string_pos("tulip",temp) > 1 return 1
	if string_pos("tripwire",temp) > 1 return 1
	if string_pos("berry",temp) > 1 return 1
	if string_pos("bush",temp) > 1 return 1
	if string_pos("barrier",temp) > 1 return 1
	return 0
}