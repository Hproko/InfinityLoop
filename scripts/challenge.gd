extends Control

@onready var var_option_button = %VarOptBtn
@onready var condition_opt_btn = %ConditOptBtn
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
	

var valor_de_i : int = -1
var posicao_final : int = bridge_size + 1

func add_items():
	var_option_button.add_item("(i = -1;")
	var_option_button.add_item("(i = 0;")
	
	condition_opt_btn.add_item("i <= 7;")
	condition_opt_btn.add_item("i <= 6;")
	condition_opt_btn.add_item("i < 7;")
	
	

func _on_option_button_item_selected(index):
	valor_de_i = index - 1


func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()

func disableBtns():
	var_option_button.disabled = true
	condition_opt_btn.disabled = true
	run_btn.disabled = true
	close_btn.disabled = true
	
func enableBtns():
	var_option_button.disabled = false
	condition_opt_btn.disabled = false
	run_btn.disabled = false
	close_btn.disabled = false
	
func _on_run_btn_pressed():
	
	aviso.hide()
	
	
	if (valor_de_i != 0) or (posicao_final != bridge_size):
		disableBtns()
		await map.build_bridge(valor_de_i, posicao_final, false)
		enableBtns()
		map.restore_bridge()
	else:
		await map.build_bridge(valor_de_i, posicao_final, true)
		hide()
		State.current_npc.challenge_passed = true
		await camera.reset_camera()
		State.start_ballon(State.current_npc.dialogue_file, "sucesso")
		State.finaliza_interacao()
		State.current_npc.ponto_excl.hide()
		queue_free()
		
	


func _on_condit_opt_btn_item_selected(index):
	
	if index == 0:
		posicao_final = bridge_size + 1
	else:
		posicao_final = bridge_size




