vh = display_get_gui_height()
vw = display_get_gui_width()


//if current_time > timeout {
	//if keyboard_check(vk_left) chunk_x_view--
	//if keyboard_check(vk_right) chunk_x_view++

	//if keyboard_check(vk_down) chunk_z_view++
	//if keyboard_check(vk_up) chunk_z_view--
	
	//timeout = current_time + 70
	//}
	
chunk_x_view = floor(obj_camera.x/16)
chunk_z_view = floor(obj_camera.y/16)

display_set_gui_size(window_get_width(), window_get_height())