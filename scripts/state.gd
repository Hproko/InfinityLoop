extends Node


@onready var screen_size = get_viewport().size

var interagindo : bool = false

var current_npc : Interactable
var main
const Balloon = preload("res://dialogue/balloon.tscn")
const challenge = preload("res://scenes/challenge.tscn")
const challenge1 = preload("res://scenes/challenge1.tscn")
const challenge2 = preload("res://scenes/challenge2.tscn")
const challenge3 = preload("res://scenes/challenge3.tscn")
const challenge4 = preload("res://scenes/challenge4.tscn")
const relatorio = preload("res://scenes/relatorio.tscn")

func start_ballon(resource, node):
	var balloon : Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, node)
	
func set_current_npc(value : Interactable) -> void:
	current_npc = value
	
func move_camera():
	var camera = get_tree().get_root().get_node("Main/Player/Camera")
	camera.move_camera_left()
	
func get_challenge(challenge_number):
	if challenge_number == 0:
		return challenge
	elif challenge_number == 1:
		return challenge1
	elif challenge_number == 2:
		return challenge2
	elif challenge_number == 3:
		return challenge3
	elif challenge_number == 4:
		return challenge4
	
func load_challenge():
	var camera = get_tree().get_root().get_node("Main/Player/Camera")
	var main = get_tree().get_root().get_node("Main")
	
	# Cada NPC vai ter gravado o numero da sua própria challenge
	var challenge = get_challenge(current_npc.challenge)
	
	var instance = challenge.instantiate()
	instance.scale.x *= .5
	instance.scale.y *= .5
	instance.set_name("challenge1")
	
	var camera_pos = camera.get_screen_center_position()
	var topLeft = screen_size.y/4
	var challenge_x = camera_pos.x + 180
	var challenge_y = camera_pos.y - topLeft
	
	instance.position = Vector2(challenge_x, challenge_y)
	main.add_child(instance)
	
	move_camera()

func back_to_map():
	get_tree().root.add_child(main)
	get_tree().current_scene = get_tree().root.get_node("Main")
	finaliza_interacao()

func mostra_relatorio():
	var rel = relatorio.instantiate()
	main = get_tree().root.get_node("Main")
	get_tree().root.remove_child(main)
	get_tree().root.add_child(rel)
	
	
	
func set_interagindo(value):
	interagindo = value

func finaliza_interacao():
	interagindo = false
	current_npc.interact_message.show()
	
func get_interagindo():
	return interagindo
	
