vh = camera_get_view_height(view_camera[0])
vw = camera_get_view_width(view_camera[0])


//draw_rectangle(0, 0, vw, vh, false)

if current_time > timeout {
	if keyboard_check(vk_left) chunk_x_view--
	if keyboard_check(vk_right) chunk_x_view++

	if keyboard_check(vk_down) chunk_z_view++
	if keyboard_check(vk_up) chunk_z_view--
	
	timeout = current_time + 70
	}
	
var scale = 4

var chunk_z = chunk_z_view
var chunk_x = chunk_x_view
var inc_z = 0
var inc_x = 0

var maxz = vh/(chunk_size*scale)
var maxx = vw/(chunk_size*scale)


timer = current_time + 200
do {
	
	if ds_chunk_sprites[? string(chunk_x)+"_"+ string(chunk_z)] = undefined {
		
	if current_time < timer {
			
		var surf = surface_create(chunk_size, chunk_size)
		surface_set_target(surf)
	
		if ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = undefined {
			
			region = buffer_load(global.save_folder + "region\\r." + string(floor(chunk_x / 32))+"."+ string(floor(chunk_z / 32)) + ".mca")
			ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))] = region
			}
			
			region = ds_regions[? string(floor(chunk_x/32))+"_"+string(floor(chunk_z/32))]
			if region >-1 {
			
		region_display_chunk(chunk_x, chunk_z, 0, 0, resources, region)
			} else draw_rectangle_color(0,0,chunk_size,chunk_size, c_purple, c_black, c_purple, c_black, false)
			
		
			surface_reset_target()
			ds_chunk_sprites[? string(chunk_x)+"_"+ string(chunk_z)]=sprite_create_from_surface(surf, 0, 0, chunk_size, chunk_size, 0, 0, 0, 0)
			
			
			}
			
		
		
		
		}
		
	var chunk_sprite = ds_chunk_sprites[? string(chunk_x)+"_"+ string(chunk_z)]
	
	if chunk_sprite != undefined {
	draw_sprite_ext(chunk_sprite, 0, (inc_x*chunk_size)*scale, (inc_z*chunk_size)*scale, scale, scale, 0, c_white, 1)
		} //else draw_sprite_ext(chunk_sprite, 0, (inc_x*chunk_size)*4, (inc_z*chunk_size)*4, 4, 4, 0, c_white, 1)
	
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
