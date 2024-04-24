extends Node

@onready var challenge = $'/root/Main/Player/Challenge'

var interagindo : bool = false

var current_npc : Interactable

func set_current_npc(value : Interactable) -> void:
	current_npc = value
	
func load_challenge():
	challenge.show()
	
func set_interagindo(value):
	interagindo = value

func finaliza_interacao():
	interagindo = false
	
func get_interagindo():
	return interagindo
