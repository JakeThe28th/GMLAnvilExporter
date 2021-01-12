function region_open(b_x, b_y, b_z, region) {

	//In-chunk block coordinates
	//var block_coord_x = b_x mod 32;
	//var block_coord_y = b_y mod 32;
	//var block_coord_z = b_z mod 32;

	//Chunk coordinates
	var chunk_coord_x = floor(b_x / 16);
	var chunk_coord_z = floor(b_z / 16);
	
	//Region file coordinates
	var region_coord_x = floor(chunk_coord_x / 32);
	var region_coord_z = floor(chunk_coord_z / 32);
	
	
	if !file_exists(region+"\\r." + string(region_coord_x) + "." + string(region_coord_z) + ".mca") {
		return -1
		}


	//Load the region file
	var buff = buffer_load(region+"\\r." + string(region_coord_x) + "." + string(region_coord_z) + ".mca")
	buffer_seek(buff, buffer_seek_start, 0)
	
	
	return buff
}