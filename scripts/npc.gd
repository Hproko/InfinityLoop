class_name Interactable extends Area2D

@export var challenge_passed: bool = false
@export var interact_type = "none"
@export var interact_value = "none"

@export var dialogue_file : DialogueResource
@export var challenge : int

@onready var interact_message = $Label
@onready var ponto_excl = $Ponto

func _ready():
	interact_message.hide()

