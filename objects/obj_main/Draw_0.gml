if global.save_folder != "none" {
#region Display chunks
var ideal = (1/60) * 1000

var scale = 1

var chunk_z = chunk_z_view
var chunk_x = chunk_x_view
var inc_z = 0
var inc_x = 0


var maxz = ceil(obj_camera.view_height/(chunk_size*scale))
var maxx = ceil(obj_camera.view_width/(chunk_size*scale))

do {
if current_time < global.base + ideal {

	//If current chunk has no sprite
	if obj_main.ds_chunk_display_instances[? string(chunk_x)+"_"+ string(chunk_z)] = undefined {
		
		//Create sprite surface
		var surf = surface_create(chunk_size, chunk_size)
		surface_set_target(surf)
	
		//Open region if needed
		if obj_main.ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = undefined {
			region = buffer_load(global.save_folder + "region\\r." + string(floor(chunk_x / 32))+"."+ string(floor(chunk_z / 32)) + ".mca")
			obj_main.ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = region
			}
			
			//Make sure region is valid
			region = obj_main.ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))]
			if region >-1 {
			
			//Draw chunk pixels
			region_display_chunk(chunk_x, chunk_z, 0, 0, obj_main.resources, region)
			
			} else draw_rectangle_color(chunk_x,chunk_z,chunk_x+chunk_size,chunk_z+chunk_size, c_purple, c_black, c_purple, c_black, false)
			
			//Reset target and save surface to sprite.
			surface_reset_target()
			obj_main.ds_chunk_display_instances[? string(chunk_x)+"_"+ string(chunk_z)]=sprite_create_from_surface(surf, 0, 0, chunk_size, chunk_size, 0, 0, 0, 0)
		}
		
	}
	
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