extends Node

@onready var tile_map : TileMap = $map
@onready var HUD : CanvasLayer = $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_npc_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print('body')
	HUD.show_message('Press E to talk to the NPC')
	tile_map.build_bridge()


func _on_npc_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	print('body_left') # Replace with function body.
	HUD.hide_message()
