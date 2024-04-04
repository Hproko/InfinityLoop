extends TileMap

var layer_sobreterreno = 2
var layer_terreno = 1
var atlas_coord_pont_normal1 = Vector2i(19, 24)
var atlas_coord_pont_normal2 = Vector2i(19, 25)
var atlas_coord_pont_normal3 = Vector2i(19, 26)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func build_bridge(npc, player_loops):
	
	var max_loops = npc.bridge_size
	var bridge_position1 = npc.bridge_position1
	var bridge_position2 = npc.bridge_position2
	var bridge_position3 = npc.bridge_position3
	var bridge_end_position1 = npc.bridge_end_position1
	var bridge_end_position2 = npc.bridge_end_position2
		
	var bridge_start_x_1 		 = bridge_position1.x
	var bridge_start_y_1         = bridge_position1.y
	var bridge_start_y_2         = bridge_position2.y
	var bridge_start_y_3         = bridge_position3.y
	
	var pos_map_ini_ponte1 = Vector2i(bridge_start_x_1 - 2, bridge_start_y_2)
	var pos_map_ini_ponte2 = Vector2i(bridge_start_x_1 - 2, bridge_start_y_3)
	
	for i in range(0, player_loops):
		var pos_map1 = Vector2i(bridge_start_x_1 + i, bridge_start_y_1)
		var pos_map2 = Vector2i(bridge_start_x_1 + i, bridge_start_y_2)
		var pos_map3 = Vector2i(bridge_start_x_1 + i, bridge_start_y_3)
		

		set_cell(layer_sobreterreno, pos_map1, 0, atlas_coord_pont_normal1)
		set_cell(layer_sobreterreno, pos_map2, 0, atlas_coord_pont_normal2)
		set_cell(layer_sobreterreno, pos_map3, 0, atlas_coord_pont_normal3)
		await get_tree().create_timer(0.5).timeout
	
	# se o player inserir um número maior do que devia vai apagar a ponte construida
	if player_loops != max_loops:
		for i in range(0, player_loops):
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

	return true	
