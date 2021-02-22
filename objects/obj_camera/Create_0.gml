view_camera[0] = camera_create_view(0, 0, 640, 480, 0, obj_view_move, 5, 5, -1, -1);

if !view_enabled
    {
    view_visible[0] = true;
    view_enabled = true;
    }
	
debug_camera = 0

camera_base_aspect = window_get_width()/window_get_height()
camera_scale_y_real = 128
camera_scale_x_real = camera_scale_y_real*camera_base_aspect

camera_scale_x = camera_scale_x_real
camera_scale_y = camera_scale_y_real

camera_scale_override = false //(True for cutscenes)

global.current_camera_controller = obj_view_move