extends TileMap

const layer_sobreterreno = 2
const layer_terreno = 1
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


func build_bridge(npc, bridge_start : int, player_loops : int):
	
	# Tamanho máximo da ponte
	var max_loops = 7
	
	var bridge_position1 = Vector2i(91, 26)
	var bridge_position2 = Vector2i(91, 27)
	var bridge_position3 = Vector2i(91, 28)
	var bridge_end_position1 = Vector2i(99, 27)
	var bridge_end_position2 = Vector2i(99, 28)
		
	var bridge_start_x_1  = bridge_position1.x
	var bridge_start_y_1  = bridge_position1.y
	var bridge_start_y_2  = bridge_position2.y
	var bridge_start_y_3  = bridge_position3.y
	
	var pos_map_ini_ponte1 = Vector2i(bridge_start_x_1 - 2, bridge_start_y_2)
	var pos_map_ini_ponte2 = Vector2i(bridge_start_x_1 - 2, bridge_start_y_3)
	
	for i in range(bridge_start, player_loops):
		var pos_map1 = Vector2i(bridge_start_x_1 + i, bridge_start_y_1)
		var pos_map2 = Vector2i(bridge_start_x_1 + i, bridge_start_y_2)
		var pos_map3 = Vector2i(bridge_start_x_1 + i, bridge_start_y_3)
		
		if i == max_loops:
			break

		set_cell(layer_sobreterreno, pos_map1, 0, atlas_coord_pont_normal1)
		set_cell(layer_sobreterreno, pos_map2, 0, atlas_coord_pont_normal2)
		set_cell(layer_sobreterreno, pos_map3, 0, atlas_coord_pont_normal3)
		await get_tree().create_timer(0.5).timeout
	
	# se o player inserir um número maior do que devia vai apagar a ponte construida
	if player_loops != max_loops or bridge_start > 0:
		for i in range(bridge_start, max_loops):
			var pos_map1 = Vector2i(bridge_start_x_1 + i, bridge_start_y_1)
			var pos_map2 = Vector2i(bridge_start_x_1 + i, bridge_start_y_2)
			var pos_map3 = Vector2i(bridge_start_x_1 + i, bridge_start_y_3)
			

			erase_cell(layer_sobreterreno, pos_map1)
			erase_cell(layer_sobreterreno, pos_map2)
			erase_cell(layer_sobreterreno, pos_map3)
			
		return false
		
	# Tira o tile de terra embaixo pra retirar a colisão e poder atravessar a ponte
	erase_cell(layer_terreno, pos_map_ini_ponte2)
	erase_cell(layer_terreno, pos_map_ini_ponte1)
	
	#Tira o tile do final da ponte
	erase_cell(layer_terreno, bridge_end_position1)
	erase_cell(layer_terreno, bridge_end_position2)
	
	npc.challenge_passed = true

	return true

func build_fence(fence_start : int, fence_end : int):
	
	var fence_start_coord1 = Vector2i(101, 29)
	var fence_start_coord2 = Vector2i(101, 30)
	var fence_end_coor1 = Vector2i(108, 29)
	var fence_end_coor2 = Vector2i(108, 30)
	
	
	for i in range(fence_start, fence_end + 1):
		
		var map_fence_pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var map_fence_pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		#var map_fence_pos3 = Vector2i(fence_start_coord1.x + i + 1, fence_start_coord1.y)
		#var map_fence_pos4 = Vector2i(fence_start_coord2.x + i + 1, fence_start_coord2.y)
		
		set_cell(layer_sobreterreno2, map_fence_pos1, 0, atlas_coord_fence1)
		set_cell(layer_sobreterreno2, map_fence_pos2, 0, atlas_coord_fence2)
		#set_cell(layer_sobreterreno2, map_fence_pos3, 0, atlas_coord_fence3)
		#set_cell(layer_sobreterreno2, map_afence_pos4, 0, atlas_coord_fence4)
		await get_tree().create_timer(0.5).timeout
	
	if fence_start != 2 or fence_end != 4:
		return false
		
	return true
	
func remove_fence():
	var fence_start_coord1 = Vector2i(101, 29)
	var fence_start_coord2 = Vector2i(101, 30)
	
	for i in range(0, 10):
		var pos1 = Vector2i(fence_start_coord1.x + i, fence_start_coord1.y)
		var pos2 = Vector2i(fence_start_coord2.x + i, fence_start_coord2.y)
		erase_cell(layer_sobreterreno2, pos1)
		erase_cell(layer_sobreterreno2, pos2)
		

