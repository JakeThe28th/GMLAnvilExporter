///region_place_block(x, y, z, region_folder)
function region_open_chunk(chunk_coord_x, chunk_coord_z, region) {
var buff = region
	
#region Get coordinates

	//In-chunk block coordinates
	//var block_coord_x = b_x mod 32;
	//var block_coord_y = b_y mod 32;
	//var block_coord_z = b_z mod 32;

	//Chunk coordinates
	//var chunk_coord_x  = floor(b_x / 16);
	//var chunk_coord_z = floor(b_z / 16);
	
	//Region file coordinates
	//var region_coord_x = floor(chunk_coord_x / 32);
	//var region_coord_z = floor(chunk_coord_z / 32);


	//Get the location in the region file of the location index for this chunk.
	var index_x = (chunk_coord_x mod 32)
	var index_z = (chunk_coord_z mod 32)
		//Handle negative coordinates
		if index_x < 0 or index_z < 0 { index_x += 32; index_z += 32 } //If coordinates are negative, add 32.
		//math
		///var index = index_x + index_z
		///index = 4 * (index *32)
		
		var index = 4 * ((index_x mod 32) + (index_z mod 32) * 32)
	
#endregion

	buffer_seek(buff, buffer_seek_start, index)
	
#region Offset and length in 4096 increments
	//Get the chunk's location offset in 4096 increments from the start of the file.
	var offset_buffer = reverse_byte_order(buff, 3)
	buffer_seek(offset_buffer, buffer_seek_start, 0)
	
		//00000001 10100101
		var byte1 = int_to_binary(buffer_read(offset_buffer, buffer_u8), 8)
		var byte2 = int_to_binary(buffer_read(offset_buffer, buffer_u8), 8)
		var byte3 = int_to_binary(buffer_read(offset_buffer, buffer_u8), 8)
	
		var bitstream = string(byte3)+string(byte2)+string(byte1)
	
		var offset = binary_to_int_edit(bitstream)
	
		buffer_delete(offset_buffer)

	//Get the length of the chunk data in 4096 increments.
	var length = buffer_read(buff, buffer_u8)

#endregion

	//Determine whether or not the chunk has been generated
	if length = 0 debug_log("MCANVIL", "Chunk hasn't been generated yet") //show_error("Chunk hasn't been generated yet", false)
	if length = 0 return -2

#region Get chunk data and decompress

	//Get the length of the chunk in bytes
	var bytecount_b = reverse_byte_order(buff, 4)
	var bytecount = buffer_read(bytecount_b, buffer_s32)
	buffer_delete(bytecount_b)

	//Create a buffer for the chunk data
	buffer_seek(buff, buffer_seek_start, offset*4096)
	var chunk_data_compressed = buffer_create(bytecount, buffer_fixed, 1)
	buffer_copy(buff, (offset*4096)+5, bytecount-5, chunk_data_compressed, 0)

	//Decompress the chunk data
	var chunk_data = buffer_decompress(chunk_data_compressed)
	buffer_delete(chunk_data_compressed)

#endregion

	var chunk_save_dir = string(nbt_save_dir + string(chunk_coord_x)+","+string(chunk_coord_z)+".mcc")

	if file_exists(chunk_save_dir) file_delete(chunk_save_dir) //If chunk is saved delete it.
	
	if chunk_data <0 {
		debug_log("MCANVIL", "Error with reading chunk data." + "X" + string(chunk_coord_x) + "Z" + string(chunk_coord_z))
		return -1
		}
	
	buffer_save(chunk_data, chunk_save_dir) //Save chunk to file
	//var nbt = nbt_start_from_buffer(chunk_data) //Read chunk

	buffer_delete(chunk_data) //Unload chunk buffer
	//buffer_delete(buff) //Unload region file

	//return nbt 
	
	



}
