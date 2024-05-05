extends Node

#@onready var challenge = $'/root/Main/Player/Challenge'
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var player = get_tree().get_root().get_node("Main/Player")
@onready var main = get_tree().get_root().get_node("Main")
@onready var screen_size = get_viewport().size

var interagindo : bool = false
var passou_desafio : bool = false
var primeira_vez : bool = true

var current_npc : Interactable

const Balloon = preload("res://dialogue/balloon.tscn")
const scene = preload("res://challenge.tscn")

func start_ballon(resource, node):
	var balloon : Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, node)
	
func set_current_npc(value : Interactable) -> void:
	current_npc = value
	
func move_camera():
	camera.move_camera_left()
	
func load_challenge():
	var instance = scene.instantiate()
	instance.scale.x *= .5
	instance.scale.y *= .5
	instance.set_name("challenge1")
	
	var camera_pos = camera.get_screen_center_position()
	var half_screen_y = screen_size.y/2
	var topLeft = screen_size.y/4
	var challenge_x = camera_pos.x + 180
	var challenge_y = camera_pos.y - topLeft
	
	instance.position = Vector2(challenge_x, challenge_y)
	main.add_child(instance)
	
	move_camera()
	
	
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
