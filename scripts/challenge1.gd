extends Control

@onready var while_option_button = $'ColorRect/CodeEdit/WhileOption'
@onready var inc_opt_btn = $'ColorRect/CodeEdit/IncOption'
@onready var run_btn = %RunBtn
@onready var close_btn = %CloseBtn
@onready var code_edit = %CodeEdit
@onready var map = $'../map'
@onready var aviso = %Aviso
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var screen_size = get_viewport().size

var tem_pt_e_virgula: String = ";"
var valor_de_i : int = 0
var incremento := -1

func _ready():
	add_items()
	aviso.text = ""

func add_items():
	while_option_button.add_item("(i <= 7);")
	while_option_button.add_item("(i <= 7)")
	while_option_button.add_item("(i < 8)")
	while_option_button.add_item("(1 < 10)")
	while_option_button.add_item("(1 = 8)")
	
	inc_opt_btn.add_item("i--;")
	inc_opt_btn.add_item("i++;")

func _on_option_button_item_selected(index):
	valor_de_i = index

func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()
	
func disableBtns():
	while_option_button.disabled = true
	inc_opt_btn.disabled = true
	run_btn.disabled = true
	close_btn.disabled = true

func enableBtns():
	while_option_button.disabled = false
	inc_opt_btn.disabled = false
	run_btn.disabled = false
	close_btn.disabled = false
	
func _on_run_btn_pressed():
	
	aviso.hide()
	
	if tem_pt_e_virgula == ";": 
		aviso.text = "Esse código causa loop infinito por conta do ';' \
					ao final do comando while, tome cuidado!"
		aviso.show()
		return
		
	if tem_pt_e_virgula == "<": 
		aviso.text = "Esse código causa loop infinito, já que a condição \
					1 < 10 sempre é verdadeira"
		aviso.show()
		return
		
	if tem_pt_e_virgula == "=": 
		aviso.text = "Esse código causa loop infinito, pois i = 8 \
					é uma atribuição, e não um comparador de igualdade (==)"
		aviso.show()
		return
		
		
	var ini_cerca = 2
	var fim_cerca = 7
	
	# Para simular loop infinito
	if incremento == -1:
		aviso.text = "Esse código causa loop infinito por conta \
		do decremento da variável i, tome cuidado!"
		aviso.show()
		fim_cerca = -12
		
	# Se o player selecionou i--; está errado 
	if incremento != 1:
		disableBtns()
		await map.build_fence(ini_cerca, fim_cerca, incremento)
		enableBtns()
		map.remove_fence()
		State.start_ballon(State.current_npc.dialogue_file, "falhou")
	else:
		disableBtns()
		await map.build_fence(ini_cerca, fim_cerca, incremento)
		enableBtns()
		hide()
		await camera.reset_camera()
		State.start_ballon(State.current_npc.dialogue_file, "sucesso")
		map.open_gate()
		State.finaliza_interacao()
		State.current_npc.challenge_passed = true
		State.current_npc.ponto_excl.hide()
		queue_free()	

func _on_while_option_item_selected(index):
	if index == 0:
		tem_pt_e_virgula = ";"
	elif index == 1:
		tem_pt_e_virgula = ""
	elif index == 2:
		tem_pt_e_virgula = ""
	elif index == 3:
		tem_pt_e_virgula = "<"
	elif index == 4:
		tem_pt_e_virgula = "="

func _on_inc_option_item_selected(index):
	if index == 0:
		incremento = -1
	elif index == 1:
		incremento = 1
