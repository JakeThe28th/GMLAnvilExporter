/// @description Insert description here
// You can write your code in this editor
//if section_list !=-1 {
if block_x != "done" {
var done = (((i*(16*16*16))+(block_x*block_y*block_z)))
var toDo = (ds_list_size(section_list)*(16*16*16))
var amount = done/toDo
draw_set_color(merge_color(c_red, c_lime, amount))
	}
//	}
draw_rectangle((x*chunk_size)+1, (y*chunk_size)+1, ((x*chunk_size)+chunk_size)-1, ((y*chunk_size)+chunk_size)-2, true)
draw_set_color(c_white)

draw_text(x, y-10, string(block_x) + ";" + string(block_y) + ";" + string(block_z))