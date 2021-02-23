if global.save_folder != "none" {
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