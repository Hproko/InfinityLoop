extends Control

@onready var for_option_button = $'ColorRect/CodeEdit/ForOption'
@onready var if_opt_btn = $'ColorRect/CodeEdit/IfOption'
@onready var run_btn = %RunBtn
@onready var close_btn = %CloseBtn
@onready var code_edit = %CodeEdit
@onready var map = $'../map'
@onready var aviso = %Aviso
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var screen_size = get_viewport().size

const bridge_size = 7

func _ready():
	add_items()
	aviso.text = ""
	

var condicao_for : String = "<"
var condicao_if : String = ">="
var incremento : int = 1
var valor_de_i : int = -1
var posicao_final : int = 0


func add_items():
	for_option_button.add_item("i < TAM_JARDIM")
	for_option_button.add_item("i <= TAM_JARDIM")
	for_option_button.add_item("i < (TAM_JARDIM - 1)")
	for_option_button.add_item("i <= (TAM_JARDIM - 1)")
	
	if_opt_btn.add_item(">=")
	if_opt_btn.add_item("<")
	if_opt_btn.add_item("==")
	if_opt_btn.add_item("!=")
	if_opt_btn.add_item("<=")


func _on_option_button_item_selected(index):
	valor_de_i = index - 1


func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()	
	
func _on_run_btn_pressed():
	
	match condicao_for:
		"<":
			match condicao_if:
				"<":
					aviso.text = "Com estas condições nenhuma árvore é plantada!"
					return
				"==":
					aviso.text = "Com estas condições apenas 3 árvores são plantadas"
					await map.build_forest(3, false)
					await map.remove_forest(3, false)
					return
				"!=":
					aviso.text = "Com estas condições as árvores são plantadas nos índices ímpares!"
					await map.build_forest(4, true)
					await map.remove_forest(4, true)
					return
		"<=":
			match condicao_if:
				"==":
					await map.build_forest(4, false)
					await map.remove_obstaculo_npc()
					hide()
					State.current_npc.challenge_passed = true
					await camera.reset_camera()
					State.start_ballon(State.current_npc.dialogue_file, "sucesso")
					State.finaliza_interacao()
					State.current_npc.ponto_excl.hide()
	
	#if condicao_for == "<=" and condicao_if == "==":
		#await map.build_forest(4)
		#hide()
		#State.current_npc.challenge_passed = true
		#await camera.reset_camera()
		#State.start_ballon(State.current_npc.dialogue_file, "sucesso")
		#State.finaliza_interacao()
		#State.current_npc.ponto_excl.hide()
	#else:
		#aviso.text = "n deu boa tenta +"
		#return
	await camera.reset_camera()
	State.finaliza_interacao()
	State.current_npc.ponto_excl.hide()
	queue_free()
	#if condicao_for == ">" or condicao_for == "=":
		#aviso.text = "Esse código nunca é executado devido as condições, tome cuidado!"
		#return
		#
		#
	#if condicao_for == "<=":
		#posicao_final = bridge_size + 1
	#else:
		#posicao_final = bridge_size
		#
	## Para simular loop infinito vamos colocar a ponte crescendo para trás
	## No máximo até 15 tábuas para trás
	#if incremento == -1:
		#posicao_final = -15
		#
	#if (valor_de_i != 0) or (posicao_final != bridge_size) or (incremento != 1):
		#await map.build_bridge(valor_de_i, posicao_final, incremento, false)
		#map.restore_bridge()
		#State.start_ballon(State.current_npc.dialogue_file, "falhou")
	#else:
		#await map.build_bridge(valor_de_i, posicao_final, incremento, true)
		#hide()
		#State.current_npc.challenge_passed = true
		#await camera.reset_camera()
		#State.start_ballon(State.current_npc.dialogue_file, "sucesso")
		#State.finaliza_interacao()
		#State.current_npc.ponto_excl.hide()
		#queue_free()

func _on_for_option_item_selected(index):
	if index == 0:
		condicao_for = "<"
	elif index == 1:
		condicao_for = "<="
	elif index == 2:
		condicao_for = "<-1"
	elif index == 3:
		condicao_for = "<=-1"


func _on_if_option_item_selected(index):
	if index == 0:
		condicao_if = ">="
	elif index == 1:
		condicao_if = "<"
	elif index == 2:
		condicao_if = "=="	
	elif index == 3:
		condicao_if = "!="	
	elif index == 4:
		condicao_if = "<="	
	
		
