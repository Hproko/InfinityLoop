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
@onready var player = get_tree().get_root().get_node("Main/Player")

const bridge_size = 7

func _ready():
	add_items()
	aviso.text = ""
	

var condicao_for : String = "<"
var condicao_if : String = ">="
var incremento : int = 1
var valor_de_i : int = -1
var posicao_final : int = 0

var for_opt_btn_empty := true
var if_opt_btn_empty := true


func add_items():
	for_option_button.add_item(" ")
	for_option_button.add_item("i < tam_floresta")
	for_option_button.add_item("i <= tam_floresta")
	for_option_button.add_item("i < (tam_floresta - 1)")
	for_option_button.add_item("i <= (tam_floresta - 1)")
	
	if_opt_btn.add_item(" ")
	if_opt_btn.add_item(">=")
	if_opt_btn.add_item("<")
	if_opt_btn.add_item("==")
	if_opt_btn.add_item("!=")
	if_opt_btn.add_item("<=")


func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()	

func disableBtns():
	run_btn.disabled = true
	close_btn.disabled = true
	if_opt_btn.disable()
	for_option_button.disable()
	
func enableBtns():
	run_btn.disabled = false
	close_btn.disabled = false
	if_opt_btn.enable()
	for_option_button.enable()
	
func _on_run_btn_pressed():
	
	if for_opt_btn_empty or if_opt_btn_empty:
		aviso.text = "Não é possível executar o código sem escolher uma opção para os botões!"
		return
		
	match condicao_for:
		"<":
			player.inc_ms_rel_oper()
			match condicao_if:
				"<":
					aviso.text = "Com estas condições nenhuma árvore é plantada!"
					player.inc_ms_rel_oper()
					return
				"==", "<=":
					aviso.text = "Com estas condições apenas 3 árvores são plantadas"
					disableBtns()
					await map.build_forest(3, false)
					await map.remove_forest(3, false)
					enableBtns()
					return
				"!=":
					aviso.text = "Com estas condições as árvores são plantadas nos índices ímpares!"
					disableBtns()
					await map.build_forest(4, true)
					await map.remove_forest(4, true)
					enableBtns()
					return
				">=":
					aviso.text = "Com estas condições as árvores são plantadas em todos os índices"
					disableBtns()
					await map.build_forest_seq(7)
					enableBtns()
					return
		"<=":
			match condicao_if:
				"!=":
					aviso.text = "Com estas condições as árvores são plantadas nos índices ímpares!"
					player.inc_ms_rel_oper()
					disableBtns()
					await map.build_forest(4, true)
					await map.remove_forest(4, true)
					enableBtns()
					return
				"==", "<=":
					aviso.text = "Parabéns, você completou o desafio!"
					aviso.add_theme_color_override("font_color", Color.GREEN)
					disableBtns()
					await map.build_forest(4, false)
					await map.remove_obstaculo_npc()
					enableBtns()
					hide()
					State.current_npc.challenge_passed = true
					await camera.reset_camera()
					State.start_ballon(State.current_npc.dialogue_file, "sucesso")
					State.finaliza_interacao()
					State.current_npc.ponto_excl.hide()
					queue_free()
				">=":
					aviso.text = "Com estas condições as árvores são plantadas em todos os índices"
					player.inc_ms_rel_oper()
					disableBtns()
					await map.build_forest_seq(8) #8
					enableBtns()
					return
				"<":
					aviso.text = "Com estas condições nenhuma árvore é plantada!"
					player.inc_ms_rel_oper()
					return
		"<-1":
			player.inc_ms_rel_oper()
			match condicao_if:
				"==", "<=":
					aviso.text = "Com estas condições apenas 3 árvores são plantadas"
					disableBtns()
					await map.build_forest(3, false)
					await map.remove_forest(3, false)
					enableBtns()
					return
				"!=":
					aviso.text = "Com estas condições as árvores são plantadas nos índices ímpares!"
					disableBtns()
					await map.build_forest(3, true)
					await map.remove_forest(3, true)
					enableBtns()
					return
				">=":
					aviso.text = "Com estas condições as árvores são plantadas em todos os índices"
					disableBtns()
					await map.build_forest_seq(6)
					enableBtns()
					return
				"<":
					aviso.text = "Com estas condições nenhuma árvore é plantada!"
					return
		"<=-1":
			player.inc_ms_rel_oper()
			match condicao_if:
				"==", "<=":
					aviso.text = "Com estas condições apenas 3 árvores são plantadas"
					disableBtns()
					await map.build_forest(3, false)
					await map.remove_forest(3, false)
					enableBtns()
					return
				"!=":
					aviso.text = "Com estas condições as árvores são plantadas nos índices ímpares!"
					disableBtns()
					await map.build_forest(4, true)
					await map.remove_forest(4, true)
					enableBtns()
					return
				">=":
					aviso.text = "Com estas condições as árvores são plantadas em todos os índices"
					disableBtns()
					await map.build_forest_seq(7)
					enableBtns()
					return
				"<":
					aviso.text = "Com estas condições nenhuma árvore é plantada!"
					return
				



func _on_if_option_option_selected(index):
	if index == 0:
		if_opt_btn_empty = true
		return
	elif index == 1:
		condicao_if = ">="
	elif index == 2:
		condicao_if = "<"
	elif index == 3:
		condicao_if = "=="
	elif index == 4:
		condicao_if = "!="
	elif index == 5:
		condicao_if = "<="
	
	if_opt_btn_empty = false



func _on_for_option_option_selected(index):
	if index == 0:
		for_opt_btn_empty = true
		return
	elif index == 1:
		condicao_for = "<"
	elif index == 2:
		condicao_for = "<="
	elif index == 3:
		condicao_for = "<-1"
	elif index == 4:
		condicao_for = "<=-1"
	
	for_opt_btn_empty = false
