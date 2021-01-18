// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function region_section_get_block(block_x, block_y, block_z, section){
			
		var section_y = nbt_path(section, ";","Y",0)[? "payload"] //Section Y
				
		
		//Get block data DS and Palette DS.
		var blockstates = nbt_path(section, ";","BlockStates",0)
		
		var palette = nbt_path(section, ";","Palette",0)
		
		if blockstates <0 or palette <0 return -1
		
		blockstates = blockstates[? "payload"]
		palette = palette[? "payload"]
		
		//Read section data.
			
		//Get the number of bits required to store the highest palette index. 
		//If it's less than 4 bits, clamp it to 4 bits, since that's the minimum.
		var index_size = clamp(ceil(log2(ds_list_size(palette)) / log2(2)), 4, 512)
			
			
		//Get the block's index in YZX order.
		var block_index = block_y * (chunk_size*chunk_size) + block_z * chunk_size + block_x
			
		
		var indexes_per_long = floor(64/index_size) //The amount of indexes in a long value (64 bits).
		var long_index = floor(block_index / (indexes_per_long)) //The index of the long that contains the block.
	
		//Thanks to Querz for making the source code to mcaselector public, it was really helpful.
		var bits = floor(ds_list_size(blockstates) / 64)				
		var clean = (power(2, bits) - 1)								
		var startbit = ceil((block_index mod indexes_per_long) * bits)	
		var index = (blockstates[| long_index]) >> startbit & clean		//Get the block's palette index
			
		
		if palette[| index] = undefined {
			debug_log("Error", "Pallete index undefined")
			}
				
			
		//Get the block id, and create a variable for blockstates
		var states = ""
		var block_id = nbt_path(palette[| index],";","Name",0)[? "payload"][? "payload"]
			
		//Get the properties DS
		var block_properties = nbt_path(palette[| index],";","Properties",0)
				
		//Repeat through properties, add to string.
		if block_properties > -1 {
			var properties_i = 0
			block_properties = block_properties[? "payload"]
			var prefix_properties = ""
					
				//Loop
				repeat ds_list_size(block_properties) {
					var current_property = block_properties[| properties_i]
					var current_string_tag = current_property[? "payload"]
					
					states += prefix_properties+string(current_property[? "name"])+"="+string(current_string_tag[? "payload"])
					
					//Adds a comma if there's more than one state
					prefix_properties = ","
					properties_i++
					}
					
				}
				
		return string(states + "|" + block_id)
}