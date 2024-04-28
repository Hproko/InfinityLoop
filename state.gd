extends Node

@onready var challenge = $'/root/Main/Player/Challenge'

var interagindo : bool = false
var passou_desafio : bool = false
var primeira_vez : bool = true

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
	
func set_passou_desafio(value):
	passou_desafio = value
	
func get_passou_desafio():
	return passou_desafio
	
func set_primeira_vez(value):
	primeira_vez = value
	
func get_primeira_vez():
	return primeira_vez
