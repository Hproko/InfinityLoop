extends TileMap

var layer_sobreterreno = 2
var layer_terreno = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func build_bridge():
	var last_loop = 10 
	var atlas_coord_pont_normal1 = Vector2i(19, 24)
	var atlas_coord_pont_normal2 = Vector2i(19, 25)
	var atlas_coord_pont_normal3 = Vector2i(19, 26)
	var atlas_coord_pont_pilar1  = Vector2i(20, 24)
	var atlas_coord_pont_pilar2  = Vector2i(20, 25)
	var atlas_coord_pont_pilar3  = Vector2i(20, 26)
	var atlas_coord_pont_pilar4  = Vector2i(20, 27)
	var atlas_coord_pont_pilar5  = Vector2i(20, 28)

	
	for i in range(0,last_loop):
		var pos_map1 = Vector2i(15 + i, 37)
		var pos_map2 = Vector2i(15 + i, 38)
		var pos_map3 = Vector2i(15 + i, 39)
		
		if i == last_loop - 3:
			print(i)
			var pos_map4 = Vector2i(pos_map3.x, pos_map3.y + 1)
			var pos_map5 = Vector2i(pos_map3.x, pos_map3.y + 2)
			set_cell(layer_sobreterreno, pos_map1, 0, atlas_coord_pont_pilar1)
			set_cell(layer_sobreterreno, pos_map2, 0, atlas_coord_pont_pilar2)
			set_cell(layer_sobreterreno, pos_map3, 0, atlas_coord_pont_pilar3)
			set_cell(layer_sobreterreno, pos_map4, 0, atlas_coord_pont_pilar4)
			set_cell(layer_sobreterreno, pos_map5, 0, atlas_coord_pont_pilar5)
			erase_cell(layer_terreno, pos_map2)
			erase_cell(layer_terreno, pos_map3)
			continue
		
		set_cell(layer_sobreterreno, pos_map1, 0, atlas_coord_pont_normal1)
		set_cell(layer_sobreterreno, pos_map2, 0, atlas_coord_pont_normal2)
		set_cell(layer_sobreterreno, pos_map3, 0, atlas_coord_pont_normal3)
		erase_cell(layer_terreno, pos_map2)
		erase_cell(layer_terreno, pos_map3)
		await get_tree().create_timer(0.5).timeout
	
	# Tira o tile de terra embaixo pra retirar a colisão e poder atravessar a ponte
	var pos_map_ini_ponte1 = Vector2i(13, 38)
	var pos_map_ini_ponte2 = Vector2i(13, 39)
	erase_cell(layer_terreno, pos_map_ini_ponte2)
	erase_cell(layer_terreno, pos_map_ini_ponte1)
