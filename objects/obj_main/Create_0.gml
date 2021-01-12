//var open = get_open_filename("NBT files|*.*","")
//var nbt_ds = nbt_start(open)

//var output = nbt_start_write(nbt_ds)
//var outpath = get_save_filename("NBT files|*.nbt", "")
//buffer_save(output, outpath)

//var awns = show_question("Gzip NBT file?")
//if awns = true compress_gzip_7z(outpath, outpath)


//----------------------------------------------------------

//58 9 64

region_place_block(2, 9, 5, region_open(2, 9, 5, "C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\New World (1)\\region"))
//region = buffer_load("C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\New World\\region\\r.0.0.mca")
//region = buffer_load("C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\Book and Quil\\region\\r.-1.-1.mca")
//region = buffer_load("C:\\Users\\nickl\\AppData\\Roaming\\.minecraft\\saves\\TT0RBIT\\region\\r.0.0.mca")

obj_out_dir = nbt_save_dir + "out.obj"
mtl_out_dir = nbt_save_dir + "out.mtl"
obj = buffer_create(1, buffer_grow, 1)
mtl = file_text_open_write(mtl_out_dir)
mtl_index = ds_map_create()
vertice_count = 0
vertice_texture_count = 0
//resources = working_directory + "1.16.1"
resources = working_directory + "OR"

cullfaces = ds_map_create()
	cullfaces[? "north"] = 1
	cullfaces[? "east"] = 1
	cullfaces[? "south"] = 1
	cullfaces[? "west"] = 1
	cullfaces[? "up"] = 1
	cullfaces[? "down"] = 1

global.ma_textures_directory =  resources + "\\assets\\minecraft\\textures"
global.ma_models_directory = resources + "\\assets\\minecraft\\models"
global.ma_blockstates_directory = resources + "\\assets\\minecraft\\blockstates"

//region_export_chunk(0,0,0,0,resources, region, obj, mtl)
//region_export_chunk(-3,-10,0,0,resources, region, obj, mtl)
region_export_chunk(0,0,0,0,resources, region, obj, mtl)

buffer_save(obj, obj_out_dir)
file_text_close(mtl)