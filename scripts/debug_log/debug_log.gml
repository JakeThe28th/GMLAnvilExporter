///debug_log(string)
///@param string
function debug_log(type, str) {
	show_debug_message("[" + type + "] " + string(current_time) + ": " +  str)

	var textfile = file_text_open_append(program_directory + "log.txt")
	file_text_write_string(textfile,"[" + type + "] " + string(current_time) + ": " +  str)
	file_text_writeln(textfile)
	file_text_close(textfile)


}
