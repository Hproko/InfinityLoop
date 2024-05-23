extends TileMap

const layer_terreno = 1
const layer_sobreterreno = 2
const layer_sobreterreno2 = 4

const atlas_coord_pont_normal1 = Vector2i(19, 24)
const atlas_coord_pont_normal2 = Vector2i(19, 25)
const atlas_coord_pont_normal3 = Vector2i(19, 26)

const atlas_coord_fence_ini = Vector2i(9, 10)
const atlas_coord_fence_ini2 = Vector2i(9, 11)
const atlas_coord_fence_fim = Vector2i(12, 10)
const atlas_coord_fence_fim2 = Vector2i(12, 11)
const atlas_coord_fence1 = Vector2i(10, 10)
const atlas_coord_fence2 = Vector2i(10, 11)
const atlas_coord_fence3 = Vector2i(11, 10)
const atlas_coord_fence4 = Vector2i(11, 11)

const atlas_coord_tree1 = Vector2i(5, 9)
const atlas_coord_tree2 = Vector2i(5, 10)
const atlas_coord_tree3 = Vector2i(5, 11)
const atlas_coord_tree4 = Vector2i(6, 9)
const atlas_coord_tree5 = Vector2i(6, 10)
const atlas_coord_tree6 = Vector2i(6, 11)

const atlas_coord_sand = Vector2i(19,14)




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
		if i < 0 or i == 7:
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
		
		# Se colocar posição inválida do vetor então espera um pouco mais
		if i < 0 or i == 7:
			await get_tree().create_timer(1.5).timeout
			return
			
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
		if i < 0 or i == 7:
			layer = layer_sobreterreno2
		else:
			layer = layer_terreno
			
		var pos_map1 = Vector2i(91 + i, 26)
		var pos_map2 = Vector2i(91 + i, 27)
		var pos_map3 = Vector2i(91 + i, 28)


		erase_cell(layer, pos_map1)
		erase_cell(layer, pos_map2)
		erase_cell(layer, pos_map3)



func build_fence(fence_start : int, fence_end : int, incremento : int):
	
	const fence_start_coord1 = Vector2i(100, 29)
	const fence_start_coord2 = Vector2i(100, 30)
	const fence_end_coor1 = Vector2i(108, 29)
	const fence_end_coor2 = Vector2i(108, 30)
	
	var layer = layer_terreno
	
	for i in range(fence_start, fence_end, incremento):
		
		if i == -14:
			break
			
		if i < 2:
			set_layer_modulate(layer_sobreterreno2, Color.RED)
			layer = layer_sobreterreno2
		else:
			layer = layer_sobreterreno
			
		var map_fence_pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var map_fence_pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)

		set_cell(layer, map_fence_pos1, 0, atlas_coord_fence1)
		set_cell(layer, map_fence_pos2, 0, atlas_coord_fence2)

		await get_tree().create_timer(0.5).timeout
		
func build_fence_loop():
	
	const fence_start_coord1 = Vector2i(100, 29)
	const fence_start_coord2 = Vector2i(100, 30)
	const fence_end_coor1 = Vector2i(108, 29)
	const fence_end_coor2 = Vector2i(108, 30)
	
	var layer = layer_sobreterreno2
	set_layer_modulate(layer_sobreterreno2, Color.RED)
	
	for i in range(2, 15):
		var map_fence_pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var map_fence_pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)

		set_cell(layer, map_fence_pos1, 0, atlas_coord_fence1)
		set_cell(layer, map_fence_pos2, 0, atlas_coord_fence2)

		await get_tree().create_timer(0.5).timeout
	
	set_layer_modulate(layer_sobreterreno2, Color.WHITE)
	
	for i in range(2, 15):	
		var pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		erase_cell(layer_sobreterreno2, pos1)
		erase_cell(layer_sobreterreno2, pos2)
	
func open_gate():
	
	var layer = layer_sobreterreno
	
	# Apaga a porteira
	var gate_pos1 = Vector2i(112, 24)
	var gate_pos2 = Vector2i(112, 25)
	var gate_pos3 = Vector2i(113, 24)
	var gate_pos4 = Vector2i(113, 25)

	erase_cell(layer, gate_pos1)
	erase_cell(layer, gate_pos2)
	erase_cell(layer, gate_pos3)
	erase_cell(layer, gate_pos4)
	
	# Pinta a porteira
	gate_pos1 = Vector2i(111, 24)
	gate_pos2 = Vector2i(111, 25)
	gate_pos3 = Vector2i(114, 24)
	gate_pos4 = Vector2i(114, 25)

	set_cell(layer, gate_pos1, 0, atlas_coord_fence_fim)
	set_cell(layer, gate_pos2, 0, atlas_coord_fence_fim2)
	set_cell(layer, gate_pos3, 0, atlas_coord_fence_ini)
	set_cell(layer, gate_pos4, 0, atlas_coord_fence_ini2)


func remove_fence():
	
	var layer = layer_terreno
	
	set_layer_modulate(layer_sobreterreno2, Color.WHITE)
	
	var fence_start_coord1 = Vector2i(100, 29)
	var fence_start_coord2 = Vector2i(100, 30)
	
	for i in range(-12, 10):
		
		if i < 2:
			layer = layer_sobreterreno2
		else:
			layer = layer_sobreterreno
			
		var pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		erase_cell(layer_sobreterreno2, pos1)
		erase_cell(layer_sobreterreno2, pos2)
		
func build_forest():
	const tree_start_coord1 = Vector2i(108, 2)
	const tree_start_coord2 = Vector2i(108, 3)
	const tree_start_coord3 = Vector2i(108, 4)
	const tree_end_coor1 = Vector2i(109, 2)
	const tree_end_coor2 = Vector2i(109, 3)
	const tree_end_coor3 = Vector2i(109, 4)
	var layer = layer_sobreterreno
	var layer_aux = 3
	
	for i in range (0, 4):
		var pos_tree_map1 = Vector2i(tree_start_coord1.x , tree_start_coord1.y + 5*i)
		var pos_tree_map2 = Vector2i(tree_start_coord2.x , tree_start_coord2.y + 5*i)
		var pos_tree_map3 = Vector2i(tree_start_coord3.x , tree_start_coord3.y + 5*i)
		var pos_tree_map4 = Vector2i(tree_end_coor1.x, tree_end_coor1.y + 5*i)
		var pos_tree_map5 = Vector2i(tree_end_coor2.x , tree_end_coor2.y + 5*i)
		var pos_tree_map6 = Vector2i(tree_end_coor3.x , tree_end_coor3.y + 5*i)	
		
		set_cell(layer, pos_tree_map1, 0, atlas_coord_tree1)
		set_cell(layer, pos_tree_map2, 0, atlas_coord_tree2)
		set_cell(layer, pos_tree_map3, 0, atlas_coord_tree3)
		set_cell(layer, pos_tree_map4, 0, atlas_coord_tree4)
		set_cell(layer, pos_tree_map5, 0, atlas_coord_tree5)
		set_cell(layer, pos_tree_map6, 0, atlas_coord_tree6)
	
		await get_tree().create_timer(0.5).timeout
	
	set_cell(layer, Vector2i(112, -1), 0, atlas_coord_sand)
	set_cell(layer, Vector2i(112, 0), 0, atlas_coord_sand)
	set_cell(layer, Vector2i(112, 1), 0, atlas_coord_sand)
	set_cell(layer, Vector2i(113, -1), 0, atlas_coord_sand)
	set_cell(layer, Vector2i(113, 0), 0, atlas_coord_sand)
	set_cell(layer, Vector2i(113, 1), 0, atlas_coord_sand)

