// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function region_blockstates_get_index(block_x, block_y, block_z, blockstates, index_size) {
			
		//Get the block's index in YZX order.
		var block_index = block_y * (chunk_size*chunk_size) + block_z * chunk_size + block_x
			
		
		var indexes_per_long = floor(64/index_size) //The amount of indexes in a long value (64 bits).
		var long_index = floor(block_index / (indexes_per_long)) //The index of the long that contains the block.
	
		//Thanks to Querz for making the source code to mcaselector public, it was really helpful.
		var bits = floor(ds_list_size(blockstates) / 64)				
		var clean = (power(2, bits) - 1)								
		var startbit = ceil((block_index mod indexes_per_long) * bits)	
		var index = (blockstates[| long_index]) >> startbit & clean		//Get the block's palette index
			
		
		return index
}