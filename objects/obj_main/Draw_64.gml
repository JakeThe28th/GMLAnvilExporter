global.in_gui = false
if gui_draw_button((vw/2)-(vw/3), 0, (vw/2)+(vw/3), 40, col_normal, col_med_light, string(global.save_folder), device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), "none.") {
	var file = get_open_filename("Minecraft Level files|*.dat", "level.dat")
	global.save_folder = filename_path(file)
	directory_destroy(nbt_save_dir)
	
	var temp = ds_map_find_first(ds_regions)
	repeat ds_map_size(ds_regions) {
		var temp1 = temp
		temp = ds_map_find_next(ds_regions, temp)
		buffer_delete(ds_regions[? temp1])
		ds_map_delete(ds_regions, temp1)
		}	
		//ds_map_destroy(ds_regions)
	
	var temp = ds_map_find_first(ds_chunk_display_instances)
	repeat ds_map_size(ds_chunk_display_instances) {
		var temp1 = temp
		temp = ds_map_find_next(ds_chunk_display_instances, temp)
		sprite_delete(ds_chunk_display_instances[? temp1])
		ds_map_delete(ds_chunk_display_instances, temp1)
		}	
		//ds_map_destroy(ds_chunk_display_instances)
		
		
	}

if chunks > -1 {
	
var pb_x1 = window_get_width()/10,
var pb_x2 = window_get_width()-(window_get_width()/10)
var pb_y1 = window_get_height()-5
var pb_y2 = window_get_height()-40
draw_rectangle(pb_x1, pb_y1, pb_x2, pb_y2, false)
draw_set_color(c_lime)

//var tdo = 10
//var done = 5
var percentage = (pb_x2-pb_x1)/(totalBlocksToDo/totalBlocksDone)
var merge = (totalBlocksDone/totalBlocksToDo)
draw_rectangle_color(pb_x1, pb_y1, pb_x1+percentage, pb_y2, c_red,  merge_color(c_red, c_lime, merge), merge_color(c_red, c_lime, merge), c_red, false)
draw_set_color(c_white)
	}