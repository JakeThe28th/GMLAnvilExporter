if global.save_folder != "none" and chunks = -1 {
#region Display chunks
var scale = 1

var chunk_z = chunk_z_view
var chunk_x = chunk_x_view
var inc_z = 0
var inc_x = 0


var maxz = ceil(obj_camera.view_height/(chunk_size*scale))
var maxx = ceil(obj_camera.view_width/(chunk_size*scale))

do {
	
	//Draw
	var chunk_sprite = obj_main.ds_chunk_display_instances[? string(chunk_x)+"_"+ string(chunk_z)]

	if chunk_sprite != undefined {
	draw_sprite_ext(chunk_sprite, 0, (chunk_x*chunk_size)*scale, (chunk_z*chunk_size)*scale, scale, scale, 0, c_white, 1)
		} //else draw_rectangle_color((chunk_x*chunk_size)*scale, (chunk_z*chunk_size)*scale,(chunk_x*chunk_size)+(chunk_size)*scale, (chunk_z*chunk_size)+(chunk_size)*scale, c_purple, c_black, c_purple, c_black, false)
		
		
	chunk_x++
	inc_x++
	if chunk_x = chunk_x_view+maxx {
		chunk_x=chunk_x_view
		chunk_z++
		}
	if inc_x = maxx {
		inc_x=0
		inc_z++
		}
	} until inc_z = maxz //or current_time > timer


#endregion
	}
	
mouse_chunk_x = floor((mouse_x-1)/chunk_size)
mouse_chunk_y = floor((mouse_y-1)/chunk_size)

if !global.in_gui and chunks = -1 {
if mouse_check_button_pressed(mb_left) {
	start_coords_x = mouse_chunk_x
	start_coords_y = mouse_chunk_y
	started_coords = true
	}
	
if mouse_check_button(mb_left) and started_coords {
	if mouse_chunk_x = undefined or mouse_chunk_y = undefined {
		start_coords_x = mouse_chunk_x
		start_coords_y = mouse_chunk_y
		} 
	
	
	//draw_rectangle((start_coords_x*chunk_size), (start_coords_y*chunk_size),(mouse_chunk_x*chunk_size)+chunk_size-1, (mouse_chunk_y*chunk_size)+chunk_size-1, false)
	global.selected_chunks[? "start_x"] = start_coords_x
	global.selected_chunks[? "start_y"] = start_coords_y
	
	global.selected_chunks[? "end_x"] = mouse_chunk_x
	global.selected_chunks[? "end_y"] = mouse_chunk_y
	}
	
if mouse_check_button_released(mb_left) and started_coords{
	global.selected_chunks[? "start_x"] = start_coords_x
	global.selected_chunks[? "start_y"] = start_coords_y
	
	global.selected_chunks[? "end_x"] = mouse_chunk_x
	global.selected_chunks[? "end_y"] = mouse_chunk_y
	}
	
}

draw_set_alpha(.5)
draw_rectangle((global.selected_chunks[? "start_x"]*chunk_size), (global.selected_chunks[? "start_y"]*chunk_size),(global.selected_chunks[? "end_x"]*chunk_size)+chunk_size-1, (global.selected_chunks[? "end_y"]*chunk_size)+chunk_size-1, false)

draw_rectangle((mouse_chunk_x*chunk_size), (mouse_chunk_y*chunk_size),(mouse_chunk_x*chunk_size)+chunk_size-1, (mouse_chunk_y*chunk_size)+chunk_size-1, false)
draw_set_alpha(1)