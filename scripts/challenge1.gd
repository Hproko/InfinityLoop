extends Control

@onready var while_option_button = $'ColorRect/CodeEdit/WhileOption'
@onready var inc_opt_btn = $'ColorRect/CodeEdit/IncOption'
@onready var code_edit = %CodeEdit
@onready var map = $'../map'
@onready var aviso = %Aviso
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var screen_size = get_viewport().size

var parentesis: String = ";"
var variante: String = "--"
var valor_de_i : int = 0

func _ready():
	add_items()
	aviso.text = ""

func add_items():
	while_option_button.add_item("(i <= 7);")
	while_option_button.add_item("(i <= 7)")
	
	inc_opt_btn.add_item("i--;")
	inc_opt_btn.add_item("i++;")

func _on_option_button_item_selected(index):
	valor_de_i = index

func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()

func _on_run_btn_pressed():
	if parentesis == ";": 
		aviso.text = "Esse código causa laço infinito por conta do ';' 
		ao final do comando while, tome cuidado!"
		return
		
	if variante == "--":
		aviso.text = "Esse código causa loop infinito, tome cuidado!"
		return
		
	if !await map.build_fence(2, 7):
		map.remove_fence()
		State.start_ballon(State.current_npc.dialogue_file, "falhou")
	else:
		hide()
		await camera.reset_camera()
		State.start_ballon(State.current_npc.dialogue_file, "sucesso")
		State.finaliza_interacao()
		State.current_npc.challenge_passed = true
		State.current_npc.ponto_excl.hide()
		queue_free()	

func _on_while_option_item_selected(index):
	if index == 0:
		parentesis = ";"
	elif index == 1:
		parentesis = ""

func _on_inc_option_item_selected(index):
	if index == 0:
		variante = "--"
	elif index == 1:
		variante = "++"
