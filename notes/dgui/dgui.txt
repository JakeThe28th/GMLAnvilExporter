vh = camera_get_view_height(view_camera[0])
vw = camera_get_view_width(view_camera[0])

if keyboard_check(vk_left) {
	scroll_amount+=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
if keyboard_check(vk_right) {
	scroll_amount-=5
	scroll_amount = clamp(scroll_amount,-10000, 0) }
	
	
draw_rectangle_color(5, (vh/2), vw-5, (vh/2)+20, col_superdark,col_superdark,col_superdark,col_superdark,false)
//loading_bar_done = .50
var loading_x = loading_bar_done * (vw-10)
draw_rectangle_color(5, (vh/2), 5 + loading_x, (vh/2)+20, col_loading_done,col_loading_done,col_loading_done,col_loading_done,false)

	
draw_rectangle_color(5, (vh/2)+25, (vw/2)-5, vh-(vh/3)+35, col_normal,col_normal,col_normal,col_normal,false)
export_options_values = gui_draw_checklist(10, (vh/2)+30, (vw/2)-10, vh-(vh/3)+30, ds_exportoptions, export_options_values, "exportOptionsChecklist")

if gui_draw_button(5, vh-(vh/3)+40, (vw/2)-5, vh-5, col_normal, col_light, "Convert!", mouse_x, mouse_y, "convertButton") {
	grayed_out_buttons = true
	if filetype_dropdown_values[? "selected"] = 0 {
		instance_create_depth(0, 0, 1, obj_parse_obj)
		}
	if filetype_dropdown_values[? "selected"] = 1 {
		instance_create_depth(0, 0, 1, obj_parse_schematic)
		}
	}
	
gui_draw_button((vw/2), (vh/2)+25, vw-5, vh-5, col_normal, col_normal, "This program is still unfinished. \n Also note: The options 'Decorations', \n 'Doors', 'Generate texture sheet', \n 'Generate materials', 'Seperate blocks', \n and Import mode haven't been implemented yet. \n \n Make sure to read the readme, \n and keep in mind if you export a world to .obj/.mtl, \n you'll need to move those files into \n the directory that contains the 'resourcepacks' folder, \n or else the textures wont load. \n also the S:number is the amount of blocks in the tile, \n and you can use the arrow keys to scroll the \n  tile selector \n \n Special thanks to CCCode, Tastac, IP and Ocelot", mouse_x, mouse_y, "none.")
	
ds_map_set(tile_list_values, "scroll_amount", scroll_amount)
gui_draw_ds_list(5, 80, vw-5, (vh/2)-5, tile_list_values, ds, "dungeons", "tiles")

draw_rectangle_color(5, 5, vw/3-3, 80, col_normal,col_normal,col_normal,col_normal,false)
level_dropdown_values = gui_draw_dropdown(15, 15, vw/3-10, 75, ds_levels, level_dropdown_values, "Level name", "levelDropDown")

draw_rectangle_color(vw/3+3, 5,vw/3+(vw/3-3) , 80, col_normal,col_normal,col_normal,col_normal,false)
objects_dropdown_values = gui_draw_dropdown(vw/3+10, 15, vw/3+(vw/3-10), 75, obj_ds, objects_dropdown_values, "Objectgroup name", "ObjDropDown")

draw_rectangle_color(vw/3+(vw/3)+3, 5,vw-6, 80, col_normal,col_normal,col_normal,col_normal,false)
filetype_dropdown_values = gui_draw_dropdown(vw/3+(vw/3)+10, 15,vw-14, 75, ds_filetype, filetype_dropdown_values, "File type" ,"fileTypeDS")

update_level(level_dropdown_values[? "selected_name"])
update_group(objects_dropdown_values[? "selected"])
update_object(tile_list_values[? "selected"])

prevlevel = global.current_level




