// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mc2obj_mtl(mtl, mtl_index, texture_name, texture_path) {
	//Creates an entry in an mtl file
	
	//Check if i've already made an entry for this texture.
	if !ds_map_exists(mtl_index, texture_name) {

			ds_map_add(mtl_index, texture_name, texture_name)
		
			#region mtl nonsense
				file_text_write_string(mtl, "newmtl " + texture_name)
				file_text_writeln(mtl)
				//file_text_write_string(mtl, "# Ns 0")
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "# Ka 0.2 0.2 0.2")
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "Kd 1 1 1")
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "Ks 0 0 0")
				//file_text_writeln(mtl)
				file_text_write_string(mtl, "# map_Ka " + texture_path)
				file_text_writeln(mtl)
				//file_text_write_string(mtl, "# for G3D, to make textures look blocky:")
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "interpolateMode NEAREST_MAGNIFICATION_TRILINEAR_MIPMAP_MINIFICATION")
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "map_Kd " + texture_path)
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "# illum 2")
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "# d 1")
				//file_text_writeln(mtl)
				//file_text_write_string(mtl, "# Tr 0")
				//file_text_writeln(mtl)
				//file_text_writeln(mtl)
				//file_text_writeln(mtl)
			#endregion
				
			}
}

function mc2obj_state(bx, by, bz, block_id, block_states, buffer, v_count, vt_count, cullfaces, mtl, mtl_index) {

	//transparent
	if block_id = "minecraft:air" return -1
	if block_id = "minecraft:cave_air" return -1
	if block_id = "minecraft:void_air" return -1
	if block_id = "minecraft:barrier" return -1
	
	if block_id = "minecraft:sign" return -1
	if block_id = "minecraft:water" return -1
	if block_id = "minecraft:lava" return -1
	
	//block entities
	if string_pos("sign", block_id) >0 return -1
	
	
	if string_pos("bedrock", block_id) > 0 {
				var error = "e"
				}
				
	if string_pos("water", block_id) > 0 {
				var error = "e"
				}
				
	if string_pos("lava", block_id) > 0 {
				var error = "e"
				}

	
	var file = global.ma_blockstates_directory + "\\" + string_replace(block_id,"minecraft:","") + ".json"

	var blockstate_json = json_load(file)
	if blockstate_json != undefined {
	if json_get(blockstate_json, "multipart")=undefined {
		
		if block_states != "" {
		
		var variant_ds = json_get(blockstate_json, "variants")
		var variant_temp = ds_map_find_first(variant_ds)
		repeat ds_map_size(variant_ds) {
			
			if variant_temp != "" then if state_values_same(block_states, variant_temp) break;
			
			variant_temp = ds_map_find_next(variant_ds, variant_temp)
			}
		
		if variant_temp = undefined variant_temp = ds_map_find_first(variant_ds)
		
		var variant_ds = json_get(variant_ds, variant_temp)
		
		} else var variant_ds = json_get(blockstate_json, "variants", block_states)
		
		if json_get(variant_ds, "model") !=undefined {
			var model = global.ma_models_directory  + "\\" + string_replace(json_get(variant_ds, "model"), "minecraft:", "") + ".json"
			mc2obj_model(bx, by, bz, string_replace_all(model, "/","\\"), buffer, v_count, vt_count, cullfaces, mtl, mtl_index)
			} else {
				random_set_seed(current_time+current_year)
				var random_n = round(random_range(0, ds_list_size(variant_ds)-1))
				var model = variant_ds[| random_n]
				var model = model[? "model"]
				var model = global.ma_models_directory + "\\" + string_replace(model, "minecraft:", "") + ".json"
				mc2obj_model(bx, by, bz, string_replace_all(model, "/","\\"), buffer, v_count, vt_count, cullfaces, mtl, mtl_index)
				}
		} else {
			//MULTIPART
			var multipart_ds = json_get(blockstate_json, "multipart")
			var states = split_string(block_states, ",")
			var i = 0
			repeat ds_list_size(multipart_ds) {
				var current_conditions = ds_list_find_value(multipart_ds, i)
				var current_conditions = ds_map_find_value(current_conditions, "when")
				
				if current_conditions != undefined {
				var eval = ds_map_find_first(current_conditions)
				
				//Eval conditions from a map.
				repeat ds_map_size(current_conditions) {
					//Get a condition from states that matches the one we're evaluating,
					//then compare it to see if the value is the same.
					var true_ = 0
					var states_i = 0
					do {
						//Get
						var condition_arr = split_string(states[states_i], "=")
						var condition = condition_arr[0]
						states_i++
						} until condition = eval
					
					//Compare
					if condition_arr[1] = ds_map_find_value(current_conditions, eval) {
						true_ = true
						} else break;
					
					var eval = ds_map_find_next(current_conditions, eval)
					}
					
				} else true_ = true
				
				if true_ = true {
					var model = ds_list_find_value(multipart_ds, i)
					var model = ds_map_find_value(model, "apply")
					var model = ds_map_find_value(model, "model")
					var model = global.ma_models_directory + "\\" + string_replace(model, "minecraft:", "") + ".json"
					mc2obj_model(bx, by, bz, string_replace_all(model, "/","\\"), buffer, v_count, vt_count, cullfaces, mtl, mtl_index)
					}
				
				
				i++
				}
			
			}
		
		if ds_exists(blockstate_json, ds_type_map) ds_map_destroy(blockstate_json)
		if ds_exists(blockstate_json, ds_type_list) ds_list_destroy(blockstate_json)
	}
	
	
	
}

function mc2obj_model(bx, by, bz, json, buffer, v_count, vt_count, cullfaces, mtl, mtl_index) {
	var json_ds = json_load(json)
	if json_ds = undefined json_ds = json //If the json was loaded in already
	
	#region Parent Handling
		if json_ds[? "parent"] !=undefined {
		//Set the parent to the current DS. Will be overwritten in loop
		var parent = json_ds
		var loaded_temp = 0
		do {
			
			//Load parent
			if parent[? "parent"] != undefined and parent[? "parent"] != "block/block" {
				var parentfile = global.ma_models_directory + "\\" + string_replace(parent[? "parent"], "minecraft:","")+".json"
				var parent = json_load(string_replace_all(parentfile, "/","\\"))
				if parent = undefined {
					debug_log("ERROR", "Parent undefined, " + string(json))
					return -1
					}
					
				var loaded_temp = 1
					}
			
			//Replace the json's elements with the parent's elements.
			if parent[? "elements"] !=undefined and loaded_temp	= 1 {
				if json_ds[? "elements"] =undefined  { 
					ds_map_delete(json_ds, "elements")
			
					ds_map_add_list(json_ds, "elements", parent[? "elements"])
					}
				}
				
				
			//Find textures from the parent and add them to the json.
			if ds_map_exists(parent, "textures") { 
				//Get the textures DS
				var textures = ds_map_find_value(parent, "textures")
				
				var iTex = ds_map_find_first(textures) //First parent texture
				repeat ds_map_size(parent[? "textures"]) {
					
					//Add it to the json, then get next one.
					ds_map_add(ds_map_find_value(json_ds, "textures"), iTex, textures[? iTex])
					var iTex = ds_map_find_next(textures, iTex)
					}
				}
	
			} until parent[? "parent"] = "block/block" or parent[? "parent"] = undefined
			//ds_map_destroy(parent) //Don't destroy the parent's DS map until the end.
		}
		#endregion	
		
	#region Get texture shorthands
		
		var textures = ds_map_find_value(json_ds, "textures") //Get the textures DS.
		
		
		//Get texture shorthands (EG #top).
		var texture_shorthands = ds_map_create() //Make DS
		
		
		//Get the first shorthand, then repeat: 
		//( Add texture shorthand to DS, get next, make material )
		var texture_temp = ds_map_find_first(textures)
		
		repeat ds_map_size(textures) {		
			if string_pos("#", textures[? texture_temp]) > 0 {
				var texture_temp_real = textures[? string_replace(textures[? texture_temp], "#","")]
				ds_map_add(texture_shorthands, "#" + texture_temp, texture_temp_real)
				} else {
					ds_map_add(texture_shorthands,"#" + texture_temp, textures[? texture_temp])
					}
				
			
			
			
			//Material		
			var namespace_valid = -1
			if string_pos("dungeons", textures[? texture_temp]) > 0 { 
				var texture_path = string_replace_all(textures[? texture_temp], "dungeons:", ma_resourcepacks)// + ".png"
				
				mc2obj_mtl(mtl, mtl_index, textures[? texture_temp], texture_path)
				namespace_valid = 1
				}		
			if string_pos("minecraft", textures[? texture_temp]) > 0 { 
				var texture_path = string_replace_all(textures[? texture_temp], "minecraft:", global.ma_textures_directory + "\\") + ".png"
				
				mc2obj_mtl(mtl, mtl_index, textures[? texture_temp], texture_path)
				namespace_valid = 1
				}
			if string_pos("missing", textures[? texture_temp]) > 0 { 
				mc2obj_mtl(mtl, mtl_index, textures[? texture_temp], "missing.png")
				namespace_valid = 1
				}
				
			if namespace_valid = -1 {
				//minecraft: namespace
				var texture_path = string_replace_all(textures[? texture_temp], "minecraft:", global.ma_textures_directory) + ".png"
				
				mc2obj_mtl(mtl, mtl_index, textures[? texture_temp], texture_path)
				}
				
			texture_temp = ds_map_find_next(textures, texture_temp)
			}
		
		#endregion
		
		
	#region Read elements.
		//Get the elements list.
		var elements = ds_map_find_value(json_ds, "elements")
		var iElement = 0
		
		
		repeat ds_list_size(elements) {
		//Get the current element, then get it's faces.
		var element = elements[| iElement]	
		var faces = element[? "faces"]


		#region From / to coordinates
		var from = element[? "from"]
		var to = element[? "to"]
	
		var from_x = ds_list_find_value(from, 0)
		var from_y = ds_list_find_value(from, 1)
		var from_z = ds_list_find_value(from, 2)
	
		var to_x = ds_list_find_value(to, 0)
		var to_y = ds_list_find_value(to, 1)
		var to_z = ds_list_find_value(to, 2)
	
	
		//Divide by 16 (to correct blender scale)
		from_x/=16
		from_y/=16
		from_z/=16
		to_x/=16
		to_y/=16
		to_z/=16
	
		//Offset it by the current block's position.
		from_x+=bx
		from_y+=by
		from_z+=bz
		to_x+=bx
		to_y+=by
		to_z+=bz
	
	#endregion


		//Read the faces.
		var face = ds_map_find_first(faces)
		repeat ds_map_size(faces) {
			//Get the DS map of the current face.
			var temp = ds_map_find_value(faces, face)
			
			var uv = temp[? "uv"]
			#region UV
				if ds_map_exists(temp, "uv") {
				//Get UV coordinates from the model.
				var uv_x1 = ds_list_find_value(uv, 0)
				var uv_y1 = ds_list_find_value(uv, 1)
				var uv_x2 = ds_list_find_value(uv, 2)
				var uv_y2 = ds_list_find_value(uv, 3)
			
			
				if face = "north" or face = "east" or face = "south" or face = "west" {
					uv_y2-= uv_y1
					uv_y1-= uv_y1
					}
			
				//Divide UV coordinates by the texture size (Usually 16)
				uv_x1/=16
				uv_y1/=16
				uv_x2/=16
				uv_y2/=16
				
				//Order the UV coordinates by least to greatest.
				var order = order_least_greatest(uv_x1, uv_x2)
				uv_x1 = order[0]
				uv_x2 = order[1]
				
				var order = order_least_greatest(uv_y1, uv_y2)
				uv_y1 = order[0]
				uv_y2 = order[1]
					} else {
						//In the case that there arent any UV coordinates, just use hardcoded ones.
						var uv_x1 = 0
						var uv_y1 = 0
						var uv_x2 = 16
						var uv_y2 = 16
					
						if face = "north" or face = "east" or face = "south"or face = "west" {
							uv_y2-= uv_y1
							uv_y1-= uv_y1
						}
					
						uv_x1/=16
						uv_y1/=16
						uv_x2/=16
						uv_y2/=16
						}
			#endregion
		
			
			//If (Face culling mumbo jumbo)
			#region Build a face
			//if ds_map_find_value(cullfaces, face) = 0 and ds_map_exists(temp, "cullface") and ds_list_find_index(ds_map_find_value(obj_gui.export_options_values, "selected"), 1) > -1 {
			if ds_map_find_value(cullfaces, face) = 0 and ds_map_exists(temp, "cullface") {
					//debug_log("MC2OBJ", "Culled face " + face + " " + string(ds_map_find_value(surrounding, face)))
				} else {
			
				//Use material
				var mat = ds_map_find_value(texture_shorthands, temp[? "texture"])
				
				if mat = undefined { 
					debug_log("MC2OBJ", "Texture not defined." )
					mat = ds_map_find_value(mtl_index, ds_map_find_first(mtl_index))
					}
			
				buffer_write(buffer, buffer_text, "usemtl " + ds_map_find_value(mtl_index, mat))
				buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
				
				//If seperate blocks
				//if ds_list_find_index(ds_map_find_value(obj_gui.export_options_values, "selected"), 7) > -1 {
				//buffer_write(buffer, buffer_text, "o " + current_block_name)
				//buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					//}
				
				//Create vertices
				switch (face) {
					case "south": 	
					#region North vertices
						//buffer_write(buffer, buffer_text, "#South face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
					#endregion
					
						break;
					case "north": 
					#region South vertices
						//buffer_write(buffer, buffer_text, "#North face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						

					#endregion

						break;
					case "west": 
					#region West vertices
						//buffer_write(buffer, buffer_text, "#West face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						
					
					#endregion

						break;
					case "east": 
					#region East vertices
						//buffer_write(buffer, buffer_text, "#East face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
					
					#endregion
					
						break;
					case "up": 		
					#region Up vertices
						//buffer_write(buffer, buffer_text, "#Up face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(to_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						

					#endregion
					
						break;
					case "down": 		
					#region Down vertices
						//buffer_write(buffer, buffer_text, "#Down face")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(from_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(to_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
					
						buffer_write(buffer, buffer_text,"v " + string(from_x) + " " + string(from_y) + " " + string(to_z))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						v_count++
						
						

					#endregion
			
						break;
					}
		
					#region Add UV coordinates.
						//buffer_write(buffer, buffer_text, "#Texture coordinates")
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x1, 1, 3) + " " + string_format(uv_y2, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x2, 1, 3) + " " + string_format(uv_y2, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x2, 1, 3) + " " + string_format(uv_y1, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++
					
						buffer_write(buffer, buffer_text,"vt " + string_format(uv_x1, 1, 3) + " " + string_format(uv_y1, 1, 3))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						vt_count++


						
					#endregion
					
					#region Create face.
					
						var verts1 = string(v_count-3) + "/" + string(vt_count-3)
						var verts2 = string(v_count-2) + "/" + string(vt_count-2)
						var verts3 = string(v_count-1) + "/" + string(vt_count-1)
						var verts4 = string(v_count) + "/" + string(vt_count)
					
						buffer_write(buffer, buffer_text, "f " + verts1 + " "+ verts2 + " " + verts3 + " "+ verts4)
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
						buffer_write(buffer, buffer_text, chr($000D) + chr($000A))
					
					#endregion
		
			}
			
			#endregion
		
			face = ds_map_find_next(faces, face)
			}
	
		iElement++
		}
	#endregion

	vertice_count = v_count
	vertice_texture_count = vt_count
	
	if json_ds[? "parent"] !=undefined ds_map_destroy(parent) //Can't delete earlier due to json deleting it's children
	ds_map_destroy(json_ds)
	
	
	// Need to rework the parse_obj to read dungeons, pass to blockstate function.
	// Then, update for bedrock edition handling.
	// Maybe use the namespace "bedrock:" ?
}


function mc2obj_build_obj_at(input_file, output_file, xpos, ypos, zpos){
	
	var vertice_count_script = 0
	var vertice_texture_count_script = 0
	var file = file_text_open_read(input_file)
	do {
		var str = file_text_read_string(file)
		file_text_readln(file)
		
		str = split_string(str, " ")
		
		switch (str[0]) {
			case "v":
			buffer_write(output_file, buffer_text, "v ")
			buffer_write(output_file, buffer_text, string(real(str[1])+xpos) + " ")
			buffer_write(output_file, buffer_text, string(real(str[2])+ypos) + " ")
			buffer_write(output_file, buffer_text, string(real(str[3])+zpos))
			buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
			vertice_count_script++
			break;
			
			case "vt":
			buffer_write(output_file, buffer_text, "vt ")
			buffer_write(output_file, buffer_text, str[1] + " ")
			buffer_write(output_file, buffer_text, str[2])
			buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
			vertice_texture_count_script++
			break;
			
			case "f":
				buffer_write(output_file, buffer_text, "f ")
				var script_i = 1
				repeat array_length(str)-1 {
					
					var strtemp = split_string(str[script_i], "/")
								
					buffer_write(output_file, buffer_text, string(real(strtemp[0])+vertice_count) + "/")
					buffer_write(output_file, buffer_text, string(real(strtemp[1])+vertice_texture_count) + " ")
					
					script_i++
					}
					
					buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
			//vertice count + number in 1/1/1, then add the amount built (in v keep track) to vertice count.
			break;
			
			}
		
		} until file_text_eof(file)
		
		vertice_count += vertice_count_script
		vertice_texture_count += vertice_texture_count_script
		file_text_close(file)
		
		buffer_write(output_file, buffer_text, chr($000D) + chr($000A))
	}
