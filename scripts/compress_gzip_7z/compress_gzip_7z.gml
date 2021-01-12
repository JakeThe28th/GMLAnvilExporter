///compress_gzip_7z(filename, outfilename)
///@param filename
///@param outfilename
function compress_gzip_7z(argument0, argument1) {
	var filename = argument0
	var outfilename = argument1

	var directory = temp_directory 

	zip_unzip("7z1900-extra.zip", directory + "7zip")
	file_copy(filename, directory + "7zip\\zip")

	do { } until file_exists(directory + "7zip\\zip")


	execute(directory + "7zip\\zip.bat", "", 0)

	do {  } until file_exists(directory + "7zip\\zip.gz")
	file_delete(directory + "7zip\\zip")
	file_copy(directory + "7zip\\zip.gz", outfilename)
	file_delete(directory + "7zip\\zip.gz")
	directory_destroy(directory + "7zip")


}
