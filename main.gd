extends Node
@onready var tile_map : TileMap = $map
var sobreterreno = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_pressed("Interact"):
		print("interagiu")
		var pos_map1
		var pos_map2
		var pos_map3
		var atlas_coord1 = Vector2i(20, 24)
		var atlas_coord2 = Vector2i(20, 25)
		var atlas_coord3 = Vector2i(20, 26)
		for i in 10:
			pos_map1 = Vector2i(16 + i, 36)
			pos_map2 = Vector2i(16 + i, 37)
			pos_map3 = Vector2i(16 + i, 38)
			tile_map.set_cell(sobreterreno, pos_map1, 0, atlas_coord1)
			tile_map.set_cell(sobreterreno, pos_map2, 0, atlas_coord2)
			tile_map.set_cell(sobreterreno, pos_map3, 0, atlas_coord3)
			await get_tree().create_timer(0.5).timeout
