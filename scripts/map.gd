extends TileMap

const layer_terreno = 1
const layer_sobreterreno = 2
const layer_behind = 3
const layer_sobreterreno2 = 4
const layer_sobreterreno3 = 5
const layer_sobreterreno4 = 6
const layer_terra = 7
const layer_terra_2 = 8
const layer_terra_3 = 9

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


const atlas_coord_flr_vermelha = Vector2(4, 13)
const atlas_coord_flr_branca = Vector2(4, 14)
const atlas_coord_flr_amarela = Vector2(4, 15)

const atlas_coord_seed1 = Vector2i(11, 15)
const atlas_coord_seed2 = Vector2i(7, 15)

const TIMER = 2.0

var modulated_cells:Dictionary


func _use_tile_data_runtime_update(_layer: int, coords: Vector2i) -> bool:
	return modulated_cells.has(coords)


func _tile_data_runtime_update(_layer: int, coords: Vector2i, tile_data: TileData) -> void:
	tile_data.modulate = modulated_cells.get(coords, Color.WHITE)
	
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
			await get_tree().create_timer(TIMER).timeout
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

#
##############################################################################
#
func build_fence(fence_start : int, fence_end : int, incremento : int):
	
	const fence_start_coord1 = Vector2i(100, 29)
	const fence_start_coord2 = Vector2i(100, 30)
	
	var layer = layer_terreno
	
	for i in range(fence_start, fence_end, incremento):
		
		if i == -14 or i == 14:
			break
			
		if i < 2 or i > 6:
			set_layer_modulate(layer_sobreterreno2, Color.RED)
			layer = layer_sobreterreno2
		else:
			layer = layer_sobreterreno
			
		var map_fence_pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var map_fence_pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)

		set_cell(layer, map_fence_pos1, 0, atlas_coord_fence1)
		set_cell(layer, map_fence_pos2, 0, atlas_coord_fence2)

		await get_tree().create_timer(0.5).timeout
		
	await get_tree().create_timer(TIMER).timeout


#####################################################################################
func build_fence_loop():
	
	const fence_start_coord1 = Vector2i(100, 29)
	const fence_start_coord2 = Vector2i(100, 30)
	
	var layer = layer_sobreterreno2
	set_layer_modulate(layer_sobreterreno2, Color.RED)
	
	for i in range(2, 15):
		var map_fence_pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var map_fence_pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		
		if i <= 5:
			layer = layer_sobreterreno
		else:
			layer = layer_sobreterreno2
			
		set_cell(layer, map_fence_pos1, 0, atlas_coord_fence1)
		set_cell(layer, map_fence_pos2, 0, atlas_coord_fence2)

		await get_tree().create_timer(0.5).timeout
	
	set_layer_modulate(layer, Color.WHITE)
	
	for i in range(2, 15):
		var pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		
		if i <= 5:
			layer = layer_sobreterreno
		else:
			layer = layer_sobreterreno2
			
		erase_cell(layer, pos1)
		erase_cell(layer, pos2)
	
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
	
	for i in range(-12, 15):
		
		if i < 2 or i > 6:
			layer = layer_sobreterreno2
		else:
			layer = layer_sobreterreno
			
		var pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		erase_cell(layer, pos1)
		erase_cell(layer, pos2)
		
func build_forest(tam_loop : int, eh_impar : bool):
	var tree_start_coord1
	var tree_start_coord2
	var tree_start_coord3
	var tree_end_coor1
	var tree_end_coor2
	var tree_end_coor3
	if !eh_impar:
		tree_start_coord1 = Vector2i(108, 2)
		tree_start_coord2 = Vector2i(108, 3)
		tree_start_coord3 = Vector2i(108, 4)
		tree_end_coor1 = Vector2i(109, 2)
		tree_end_coor2 = Vector2i(109, 3)
		tree_end_coor3 = Vector2i(109, 4)
	else:
		tree_start_coord1 = Vector2i(108, 5)
		tree_start_coord2 = Vector2i(108, 6)
		tree_start_coord3 = Vector2i(108, 7)
		tree_end_coor1 = Vector2i(109, 5)
		tree_end_coor2 = Vector2i(109, 6)
		tree_end_coor3 = Vector2i(109, 7)
	
	var layer = layer_sobreterreno2
	
	if (tam_loop != 4 or eh_impar):
		set_layer_modulate(layer_sobreterreno2, Color.RED)
	else:
		layer = layer_sobreterreno
		set_layer_modulate(layer_sobreterreno2, Color.WHITE)
	
	for i in range (0, tam_loop):
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
		
	await get_tree().create_timer(TIMER).timeout
		
func remove_forest(tam_loop : int, eh_impar : bool):
	var tree_start_coord1
	var tree_start_coord2
	var tree_start_coord3
	var tree_end_coor1
	var tree_end_coor2
	var tree_end_coor3
	set_layer_modulate(layer_sobreterreno2, Color.WHITE)
	if !eh_impar:
		tree_start_coord1 = Vector2i(108, 2)
		tree_start_coord2 = Vector2i(108, 3)
		tree_start_coord3 = Vector2i(108, 4)
		tree_end_coor1 = Vector2i(109, 2)
		tree_end_coor2 = Vector2i(109, 3)
		tree_end_coor3 = Vector2i(109, 4)
	else:
		tree_start_coord1 = Vector2i(108, 5)
		tree_start_coord2 = Vector2i(108, 6)
		tree_start_coord3 = Vector2i(108, 7)
		tree_end_coor1 = Vector2i(109, 5)
		tree_end_coor2 = Vector2i(109, 6)
		tree_end_coor3 = Vector2i(109, 7)
	var layer = layer_sobreterreno2
	
	for i in range (0, tam_loop):
		var pos_tree_map1 = Vector2i(tree_start_coord1.x , tree_start_coord1.y + 5*i)
		var pos_tree_map2 = Vector2i(tree_start_coord2.x , tree_start_coord2.y + 5*i)
		var pos_tree_map3 = Vector2i(tree_start_coord3.x , tree_start_coord3.y + 5*i)
		var pos_tree_map4 = Vector2i(tree_end_coor1.x, tree_end_coor1.y + 5*i)
		var pos_tree_map5 = Vector2i(tree_end_coor2.x , tree_end_coor2.y + 5*i)
		var pos_tree_map6 = Vector2i(tree_end_coor3.x , tree_end_coor3.y + 5*i)	
		
		erase_cell(layer, pos_tree_map1)
		erase_cell(layer, pos_tree_map2)
		erase_cell(layer, pos_tree_map3)
		erase_cell(layer, pos_tree_map4)
		erase_cell(layer, pos_tree_map5)
		erase_cell(layer, pos_tree_map6)
	
func remove_obstaculo_npc():
	var layer = layer_sobreterreno3
	
	for i in range(111, 115):
		set_cell(layer, Vector2i(i, -2))
		set_cell(layer, Vector2i(i, -1))
		set_cell(layer, Vector2i(i, 0))
		set_cell(layer, Vector2i(i, 1))
	
	#set_cell(layer, Vector2i(112, -1), 0, atlas_coord_sand)
	#set_cell(layer, Vector2i(112, 0), 0, atlas_coord_sand)
	#set_cell(layer, Vector2i(112, 1), 0, atlas_coord_sand)
	#set_cell(layer, Vector2i(113, -1), 0, atlas_coord_sand)
	#set_cell(layer, Vector2i(113, 0), 0, atlas_coord_sand)
	#set_cell(layer, Vector2i(113, 1), 0, atlas_coord_sand)
	
func build_forest_seq(tam_loop : int):
	var tree_start_coord1
	var tree_start_coord2
	var tree_start_coord3
	var tree_end_coor1
	var tree_end_coor2
	var tree_end_coor3
	tree_start_coord1 = Vector2i(108, 2)
	tree_start_coord2 = Vector2i(108, 3)
	tree_start_coord3 = Vector2i(108, 4)
	tree_end_coor1 = Vector2i(109, 2)
	tree_end_coor2 = Vector2i(109, 3)
	tree_end_coor3 = Vector2i(109, 4)
	
	var layer = layer_sobreterreno2
	
	set_layer_modulate(layer_sobreterreno2, Color.RED)
	
	for i in range (0, tam_loop):
		var pos_tree_map1 = Vector2i(tree_start_coord1.x , tree_start_coord1.y + 3*i)
		var pos_tree_map2 = Vector2i(tree_start_coord2.x , tree_start_coord2.y + 3*i)
		var pos_tree_map3 = Vector2i(tree_start_coord3.x , tree_start_coord3.y + 3*i)
		var pos_tree_map4 = Vector2i(tree_end_coor1.x, tree_end_coor1.y + 3*i)
		var pos_tree_map5 = Vector2i(tree_end_coor2.x , tree_end_coor2.y + 3*i)
		var pos_tree_map6 = Vector2i(tree_end_coor3.x , tree_end_coor3.y + 3*i)	
		
		set_cell(layer, pos_tree_map1, 0, atlas_coord_tree1)
		set_cell(layer, pos_tree_map2, 0, atlas_coord_tree2)
		set_cell(layer, pos_tree_map3, 0, atlas_coord_tree3)
		set_cell(layer, pos_tree_map4, 0, atlas_coord_tree4)
		set_cell(layer, pos_tree_map5, 0, atlas_coord_tree5)
		set_cell(layer, pos_tree_map6, 0, atlas_coord_tree6)
	
		await get_tree().create_timer(0.5).timeout
		
	await get_tree().create_timer(2).timeout	
	set_layer_modulate(layer_sobreterreno2, Color.WHITE)
	set_layer_modulate(layer_sobreterreno, Color.WHITE)
	
	for i in range (0, tam_loop):
		var pos_tree_map1 = Vector2i(tree_start_coord1.x , tree_start_coord1.y + 3*i)
		var pos_tree_map2 = Vector2i(tree_start_coord2.x , tree_start_coord2.y + 3*i)
		var pos_tree_map3 = Vector2i(tree_start_coord3.x , tree_start_coord3.y + 3*i)
		var pos_tree_map4 = Vector2i(tree_end_coor1.x, tree_end_coor1.y + 3*i)
		var pos_tree_map5 = Vector2i(tree_end_coor2.x , tree_end_coor2.y + 3*i)
		var pos_tree_map6 = Vector2i(tree_end_coor3.x , tree_end_coor3.y + 3*i)	
		
		erase_cell(layer, pos_tree_map1)
		erase_cell(layer, pos_tree_map2)
		erase_cell(layer, pos_tree_map3)
		erase_cell(layer, pos_tree_map4)
		erase_cell(layer, pos_tree_map5)
		erase_cell(layer, pos_tree_map6)
	
	if tam_loop == 8:
		const fence_start_coord1 = Vector2i(107, 24)
		const fence_start_coord2 = Vector2i(108, 25)
		
		for i in range(0, 3):
			var map_fence_pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
			var map_fence_pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)

			set_cell(layer_sobreterreno, map_fence_pos1, 0, atlas_coord_fence1)
			set_cell(layer_sobreterreno, map_fence_pos2, 0, atlas_coord_fence2)
			
	await get_tree().create_timer(TIMER).timeout
	

func clear_garden():
	
	const ini_jardim = Vector2(168, -3)
	
	set_layer_modulate(layer_sobreterreno4, Color.WHITE)
	erase_cell(layer_sobreterreno4, Vector2(178, -3))
	erase_cell(layer_sobreterreno4, Vector2(168, 7))
	erase_cell(layer_sobreterreno4, Vector2(178, 7))
	
	for i in range(0, 10):
		for j in range(0, 10):
			erase_cell(layer_sobreterreno, ini_jardim + Vector2(i, j))
			
	

func build_garden(max_i, max_j, cond_branca, cond_amarela, cond_vermel):
	
	const ini_jardim = Vector2(168, -3)
	var pos 
	var layer = layer_sobreterreno
	var tile_colocada : bool = false
	
	var time = 0.125
	
		
	for i in range(0, max_i):
		for j in range(0, max_j):
			
			if max_j == 20:
				i = 0
				
			pos = ini_jardim + Vector2(j, i)
			tile_colocada = false
			
			if pos.x == 178 or pos.y == 7:
				layer = layer_sobreterreno4
			else:
				layer = layer_sobreterreno
			
			match cond_branca:
				'==':
					if i == j:
						set_cell(layer, pos, 0, atlas_coord_flr_branca)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
				'>':
					if i > j:
						set_cell(layer, pos, 0, atlas_coord_flr_branca)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
				'<':
					if i < j:
						set_cell(layer, pos, 0, atlas_coord_flr_branca)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
						
			match cond_vermel:
				'==':
					if i == j:
						set_cell(layer, pos, 0, atlas_coord_flr_vermelha)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
				'>':
					if i > j:
						set_cell(layer, pos, 0, atlas_coord_flr_vermelha)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
				'<':
					if i < j:
						set_cell(layer, pos, 0, atlas_coord_flr_vermelha)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
						
			match cond_amarela:
				'==':
					if i == j:
						set_cell(layer, pos, 0, atlas_coord_flr_amarela)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
				'>':
					if i > j:
						set_cell(layer, pos, 0, atlas_coord_flr_amarela)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
				'<':
					if i < j:
						set_cell(layer, pos, 0, atlas_coord_flr_amarela)
						await get_tree().create_timer(time).timeout
						tile_colocada = true
				
			if pos.x == 178 or pos.y == 7:
				if tile_colocada:
					set_layer_modulate(layer, Color.RED)
					await get_tree().create_timer(4).timeout
					return 

func plant(tam_i, correct):
	const plantation1 = Vector2i(107, -7)
	const plantation2 = Vector2i(107, -6)
	
	var layer = layer_terra_2
	
	#Layer da terra
	set_layer_modulate(layer_terra, Color.SADDLE_BROWN)
	
	await get_tree().create_timer(1).timeout
	
	if correct:
		for i in range(0, tam_i):
			var map_plant_1 = Vector2i(plantation1.x + i, plantation1.y)
			var map_plant_2 = Vector2i(plantation2.x + i, plantation2.y)
			
			#if i < 5:
			set_cell(layer, map_plant_1, 0, atlas_coord_seed1)
			set_cell(layer, map_plant_2, 0, atlas_coord_seed2)
			
			
			await get_tree().create_timer(0.5).timeout
		remove_bushes()
	else:
		for i in range(0, tam_i):
			var map_plant_1 = Vector2i(plantation1.x + i, plantation1.y)
			var map_plant_2 = Vector2i(plantation2.x + i, plantation2.y)
			
			if i < 5:
				set_cell(layer_terra_2, map_plant_1, 0, atlas_coord_seed1)
				set_cell(layer_terra_2, map_plant_2, 0, atlas_coord_seed2)
			elif (i >= 5) and (i < 7):
				set_layer_modulate(layer_terra_3, Color.RED)
				set_cell(layer_terra_3, map_plant_1, 0, atlas_coord_seed1)
				set_cell(layer_terra_2, map_plant_2, 0, atlas_coord_seed2)
			elif i >= 7:
				set_layer_modulate(layer_terra_3, Color.RED)
				set_cell(layer_terra_3, map_plant_1, 0, atlas_coord_seed1)
				set_cell(layer_terra_3, map_plant_2, 0, atlas_coord_seed2)
			
			await get_tree().create_timer(0.5).timeout
		await get_tree().create_timer(2).timeout
		clean_terrain()
		
func clean_terrain():
	const plantation1 = Vector2i(107, -7)
	const plantation2 = Vector2i(107, -6)
	
	var layer = layer_terra_2
	
	set_layer_modulate(layer_terra, Color.WHITE)
	
	#Layer da terra
	set_layer_modulate(layer_terra, Color.WHITE)
	
	for i in range(0, 8):
		var map_plant_1 = Vector2i(plantation1.x + i, plantation1.y)
		var map_plant_2 = Vector2i(plantation2.x + i, plantation2.y)
		
		erase_cell(layer, map_plant_1)
		erase_cell(layer, map_plant_2)
		
		erase_cell(layer_terra_3, map_plant_1)
		erase_cell(layer_terra_3, map_plant_2)

func remove_bushes():
	for i in range(0, 6):
		erase_cell(layer_sobreterreno, Vector2i(129, -6 - i))
		erase_cell(layer_sobreterreno, Vector2i(130, -6 - i))
		erase_cell(layer_sobreterreno, Vector2i(129, -5 - i))
		erase_cell(layer_sobreterreno, Vector2i(130, -5 - i))
	
	for i in range(0, 4):
		erase_cell(layer_sobreterreno2, Vector2i(130, -7 - i))
		erase_cell(layer_sobreterreno2, Vector2i(130, -6 - i))
		erase_cell(layer_sobreterreno2, Vector2i(131, -7 - i))
		erase_cell(layer_sobreterreno2, Vector2i(131, -6 - i))

