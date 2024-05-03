extends Node

#@onready var challenge = $'/root/Main/Player/Challenge'
@onready var camera = $'/root/Main/Player/Camera2D'

var interagindo : bool = false
var passou_desafio : bool = false
var primeira_vez : bool = true

var current_npc : Interactable

const Balloon = preload("res://dialogue/balloon.tscn")

func start_ballon(resource, node):
	var balloon : Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, node)
	
func set_current_npc(value : Interactable) -> void:
	current_npc = value
	
func load_challenge():
	camera.move_camera_left()
	var scene = preload("res://challenge.tscn")
	var instance = scene.instantiate()
	instance.scale.x *= .5
	instance.scale.y *= .5
	instance.set_name("challenge1")
	
	var player = get_tree().get_root().get_node("Main/Player")
	instance.position = Vector2(player.position.x + 150, player.position.y)
	
	
	get_tree().get_root().get_node("Main").add_child(instance)
	#challenge.show()
	
func set_interagindo(value):
	interagindo = value

func finaliza_interacao():
	interagindo = false
	
func get_interagindo():
	return interagindo
	
func set_passou_desafio(value):
	passou_desafio = value
	
func get_passou_desafio():
	return passou_desafio
	
func set_primeira_vez(value):
	primeira_vez = value
	
func get_primeira_vez():
	return primeira_vez
