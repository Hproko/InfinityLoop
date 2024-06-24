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
@onready var player = get_tree().get_root().get_node("Main/Player")

const bridge_size = 7

func _ready():
	add_items()
	aviso.text = ""
	

var valor_de_i : int = -1
var posicao_final : int = bridge_size + 1
var option_button_empty := true
var condition_button_empty := true

func add_items():
	var_option_button.add_item(" ")
	var_option_button.add_item("(i = -1;")
	var_option_button.add_item("(i = 0;")
	
	condition_opt_btn.add_item(" ")
	condition_opt_btn.add_item("i <= 7;")
	condition_opt_btn.add_item("i <= 6;")
	condition_opt_btn.add_item("i < 7;")
	

func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()

func disableBtns():
	var_option_button.disable()
	condition_opt_btn.disable()
	run_btn.disabled = true
	close_btn.disabled = true
	
func enableBtns():
	var_option_button.enable()
	condition_opt_btn.enable()
	run_btn.disabled = false
	close_btn.disabled = false
	
func _on_run_btn_pressed():
	
	aviso.hide()
	
	if option_button_empty or condition_button_empty:
		aviso.text = "Não é possível executar o código sem escolher uma opção para os botões!"
		aviso.show()
		return
		
	if posicao_final != bridge_size:
		aviso.text = "Você tentou acessar a posição 7 do Vetor, isso causa memória corrompida e aborta o programa!"
		aviso.show()
	
	if valor_de_i == -1:
		aviso.text = "Você tentou acessar a posição -1 do Vetor, isso causa memória corrompida e aborta o programa!"
		aviso.show()
	
	if (valor_de_i != 0) or (posicao_final != bridge_size):
		player.inc_ms_pos_invalid()
		disableBtns()
		await map.build_bridge(valor_de_i, posicao_final, false)
		enableBtns()
		map.restore_bridge()
	else:
		aviso.text = "Você conseguiu!"
		aviso.show()
		aviso.add_theme_color_override("font_color", Color.GREEN)
		await map.build_bridge(valor_de_i, posicao_final, true)
		hide()
		State.current_npc.challenge_passed = true
		await camera.reset_camera()
		State.start_ballon(State.current_npc.dialogue_file, "sucesso")
		State.finaliza_interacao()
		State.current_npc.ponto_excl.hide()
		queue_free()
		


func _on_var_opt_btn_option_selected(index):
	
	if index == 0:
		option_button_empty = true
	elif index == 1:
		option_button_empty = false
		valor_de_i = -1
	elif index == 2:
		option_button_empty = false
		valor_de_i = 0


func _on_condit_opt_btn_option_selected(index):
	if index == 0:
		condition_button_empty = true
	elif index == 1:
		posicao_final = bridge_size + 1
		condition_button_empty = false
	else:
		posicao_final = bridge_size
		condition_button_empty = false
