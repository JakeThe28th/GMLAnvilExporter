//var open = get_open_filename("NBT files|*.*","")
//var nbt_ds = nbt_start(open)

//var output = nbt_start_write(nbt_ds)
//var outpath = get_save_filename("NBT files|*.nbt", "")
//buffer_save(output, outpath)

//var awns = show_question("Gzip NBT file?")
//if awns = true compress_gzip_7z(outpath, outpath)


//----------------------------------------------------------

//58 9 64

//region_place_block(2, 9, 5, region_open(2, 9, 5, "C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\New World (1)\\region"))
//region = buffer_load("C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\New World\\region\\r.0.0.mca")
//region = buffer_load("C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\Book and Quil\\region\\r.-1.-1.mca")
//region = buffer_load("C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\TT0RBIT\\region\\r.0.0.mca")
//region = buffer_load("C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\_OR_\\region\\r.-1.-1.mca")
//global.save_folder = "C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\_OR_\\"
//global.save_folder = "C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\New World\\"
global.save_folder = "none"
//buffer_seek(region, buffer_seek_start, 0)


//obj_out_dir = nbt_save_dir + "out.obj"
//mtl_out_dir = nbt_save_dir + "out.mtl"
//obj_out_dir = nbt_save_dir + ""
//mtl_out_dir = nbt_save_dir + ""
//obj = buffer_create(1, buffer_grow, 1)
//mtl = file_text_open_write(mtl_out_dir)
//mtl_index = ds_map_create()
//vertice_count = 0
//vertice_texture_count = 0
//resources = working_directory + "1.16.1"
resources = "OR" //working_directory + "OR"

cullfaces = ds_map_create()
	cullfaces[? "north"] = 1
	cullfaces[? "east"] = 1
	cullfaces[? "south"] = 1
	cullfaces[? "west"] = 1
	cullfaces[? "up"] = 1
	cullfaces[? "down"] = 1

global.ma_textures_directory = resources + "\\assets\\minecraft\\textures"
global.ma_models_directory = resources + "\\assets\\minecraft\\models"
global.ma_blockstates_directory = resources + "\\assets\\minecraft\\blockstates"


//region_export_chunk(0,0,0,0,resources, region, obj, mtl)
//region_export_chunk(-3,-10,0,0,resources, region, obj, mtl)

//region_export_chunk(0,0,0,0,resources, region, obj, mtl)

//buffer_save(obj, obj_out_dir)
//file_text_close(mtl)


//chunk_sprite_ds = ds_map_create()

//miblockcolors = json_load(working_directory + "blockpreview.midata")

//spritetemp = -1

ds_chunk_display_instances = ds_map_create()
ds_regions = ds_map_create()


chunk_x_view=0
chunk_z_view=0

timeout=0

grayed_out_buttons = false
global.current_menu = false

directory_destroy(nbt_save_dir)

instance_create_depth(0, 0, -6, obj_view_move)
instance_create_depth(0, 0, -6, obj_camera)