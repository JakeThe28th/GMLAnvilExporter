vh = display_get_gui_height()
vw = display_get_gui_width()

step = !step

//if current_time > timeout {
	//if keyboard_check(vk_left) chunk_x_view--
	//if keyboard_check(vk_right) chunk_x_view++

	//if keyboard_check(vk_down) chunk_z_view++
	//if keyboard_check(vk_up) chunk_z_view--
	
	//timeout = current_time + 70
	//}
	

if step {
chunk_x_view = floor(obj_camera.x/16)
chunk_z_view = floor(obj_camera.y/16)
	}

display_set_gui_size(window_get_width(), window_get_height())


if global.save_folder != "none" {
#region Display chunks
var ideal = (1/480) * 1000
var timer = current_time

var scale = 1

var chunk_z = chunk_z_view
var chunk_x = chunk_x_view
var inc_z = 0
var inc_x = 0


var maxz = ceil(obj_camera.view_height/(chunk_size*scale))
var maxx = ceil(obj_camera.view_width/(chunk_size*scale))

do {
if current_time < timer + ideal {

	//If current chunk has no sprite
	if ds_chunk_display_instances[? string(chunk_x)+"_"+ string(chunk_z)] = undefined {
		
		//Create sprite surface
		var surf = surface_create(chunk_size, chunk_size)
		surface_set_target(surf)
	
		//Open region if needed
		if ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = undefined {
			var region = buffer_load(global.save_folder + "region\\r." + string(floor(chunk_x / 32))+"."+ string(floor(chunk_z / 32)) + ".mca")
			ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = region
			}
			
			//Make sure region is valid
			var region = ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))]
			if region >-1 {
			
			//Draw chunk pixels
			region_display_chunk_fast(chunk_x, chunk_z, 0, 0, obj_main.resources, region)
			
			} else draw_rectangle_color(chunk_x,chunk_z,chunk_x+chunk_size,chunk_z+chunk_size, c_purple, c_black, c_purple, c_black, false)
			
			//Reset target and save surface to sprite.
			surface_reset_target()
			ds_chunk_display_instances[? string(chunk_x)+"_"+ string(chunk_z)]=sprite_create_from_surface(surf, 0, 0, chunk_size, chunk_size, 0, 0, 0, 0)
			surface_free(surf)
		}
		
	} //else break;
	
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