//Get Aspect ratio of window
camera_base_aspect = window_get_width()/window_get_height()
view_width = camera_get_view_width(view_camera[0])
view_height = camera_get_view_height(view_camera[0])

//Get a perpectly centered camera position (ideal position)
var cam_pos_x = global.current_camera_controller.x - (view_width/2)
var cam_pos_y = global.current_camera_controller.y - (view_height/2)

//If debug camera is off
if debug_camera = 0 {

//Linearly interpolate the camera's position to the camera's ideal position for smooth camera.
x = lerp(x, cam_pos_x, .1)
y = lerp(y, cam_pos_y, .1)

	}


camera_set_view_pos(view_camera[0], x, y)
camera_set_view_size(view_camera[0], lerp(view_width, camera_scale_x, .25), lerp(view_height, camera_scale_y,.25))


	
#region Debug movement and scaling.
if debug_camera = 1 {
	//if keyboard_check(vk_left) x-=3
	//if keyboard_check(vk_right) x+=3
	//if keyboard_check(vk_up) y-=3
	//if keyboard_check(vk_down) y+=3
	
} //////////
	
	if mouse_wheel_down() { 
		camera_scale_y+=50
		camera_scale_x=camera_scale_y*camera_base_aspect
		}
		
	if mouse_wheel_up() { 
		camera_scale_y-=50
		camera_scale_x=camera_scale_y*camera_base_aspect
		}

#endregion
	
if camera_scale_x<0 camera_scale_x=6
if camera_scale_y<0 camera_scale_y=6
	
surface_resize(application_surface, camera_scale_x, camera_scale_y);