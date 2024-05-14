extends TileMap

const layer_terreno = 1
const layer_sobreterreno = 2
const layer_sobreterreno2 = 4

const atlas_coord_pont_normal1 = Vector2i(19, 24)
const atlas_coord_pont_normal2 = Vector2i(19, 25)
const atlas_coord_pont_normal3 = Vector2i(19, 26)

const atlas_coord_fence1 = Vector2i(10, 10)
const atlas_coord_fence2 = Vector2i(10, 11)
const atlas_coord_fence3 = Vector2i(11, 10)
const atlas_coord_fence4 = Vector2i(11, 11)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func build_bridge(ini_vetor : int, fim_vetor : int, acertou : bool):
	
	var layer = layer_terreno
	
		
	const bridge_position1 = Vector2i(91, 26)
	const bridge_position2 = Vector2i(91, 27)
	const bridge_position3 = Vector2i(91, 28)
	const bridge_end_position1 = Vector2i(99, 27)
	const bridge_end_position2 = Vector2i(99, 28)
		
	var bridge_start_x  = bridge_position1.x
	var bridge_start_y_1  = bridge_position1.y
	var bridge_start_y_2  = bridge_position2.y
	var bridge_start_y_3  = bridge_position3.y
	
	var pos_map_ini_ponte1 = Vector2i(bridge_start_x - 2, bridge_start_y_2)
	var pos_map_ini_ponte2 = Vector2i(bridge_start_x - 2, bridge_start_y_3)
	
	for i in range(ini_vetor, fim_vetor):
		
		# Coloca em vermelho posições inválidas do vetor
		if i == -1 or i == 7:
			set_layer_modulate(layer_sobreterreno2, Color.RED)
			layer = layer_sobreterreno2
		else:
			layer = layer_terreno
		
		var pos_map1 = Vector2i(bridge_start_x + i, bridge_start_y_1)
		var pos_map2 = Vector2i(bridge_start_x + i, bridge_start_y_2)
		var pos_map3 = Vector2i(bridge_start_x + i, bridge_start_y_3)
		
		
		set_cell(layer, pos_map1, 0, atlas_coord_pont_normal1)
		set_cell(layer, pos_map2, 0, atlas_coord_pont_normal2)
		set_cell(layer, pos_map3, 0, atlas_coord_pont_normal3)
		await get_tree().create_timer(0.5).timeout
	
		
	if acertou:
		# Tira o tile de terra embaixo pra retirar a colisão e poder atravessar a ponte
		erase_cell(layer, pos_map_ini_ponte2)
		erase_cell(layer, pos_map_ini_ponte1)
	
		#Tira o tile do final da ponte
		erase_cell(layer, bridge_end_position1)
		erase_cell(layer, bridge_end_position2)


func restore_bridge():	
	var layer = layer_terreno
	
	set_layer_modulate(layer_sobreterreno2, Color.WHITE)
	# Restaura o meio da ponte
	for i in range(-1, 8):
		
		# Na posicao inicial e final da ponte colocamos as tiles na layer sobreterreno2
		if i == -1 or i == 7:
			layer = layer_sobreterreno2
		else:
			layer = layer_terreno
			
		var pos_map1 = Vector2i(91 + i, 26)
		var pos_map2 = Vector2i(91 + i, 27)
		var pos_map3 = Vector2i(91 + i, 28)
			

		erase_cell(layer, pos_map1)
		erase_cell(layer, pos_map2)
		erase_cell(layer, pos_map3)
				
	
	
func build_fence(fence_start : int, fence_end : int):
	
	const fence_start_coord1 = Vector2i(100, 29)
	const fence_start_coord2 = Vector2i(100, 30)
	const fence_end_coor1 = Vector2i(108, 29)
	const fence_end_coor2 = Vector2i(108, 30)
	
	
	for i in range(fence_start, fence_end):
		
		var map_fence_pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var map_fence_pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		#var map_fence_pos3 = Vector2i(fence_start_coord1.x + i + 1, fence_start_coord1.y)
		#var map_fence_pos4 = Vector2i(fence_start_coord2.x + i + 1, fence_start_coord2.y)
		
		set_cell(layer_sobreterreno2, map_fence_pos1, 0, atlas_coord_fence1)
		set_cell(layer_sobreterreno2, map_fence_pos2, 0, atlas_coord_fence2)
		#set_cell(layer_sobreterreno2, map_fence_pos3, 0, atlas_coord_fence3)
		#set_cell(layer_sobreterreno2, map_afence_pos4, 0, atlas_coord_fence4)
		await get_tree().create_timer(0.5).timeout
	
	if fence_start != 2 or fence_end != 5:
		return false
		
	return true
	
func remove_fence():
	var fence_start_coord1 = Vector2i(100, 29)
	var fence_start_coord2 = Vector2i(100, 30)
	
	for i in range(0, 10):
		var pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		erase_cell(layer_sobreterreno2, pos1)
		erase_cell(layer_sobreterreno2, pos2)
		

