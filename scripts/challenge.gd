extends Control

@onready var var_option_button = %VarOptBtn
@onready var condition_opt_btn = %ConditOptBtn
@onready var var_update_btn = %VarUpdateBtn
@onready var code_edit = %CodeEdit
@onready var map = $'../map'
@onready var aviso = %Aviso
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var screen_size = get_viewport().size

func _ready():
	add_items()
	aviso.text = ""
	

var condicao : String = ">"
var incremento : int = 1
var valor_de_i : int = 0
var posicao_final : int = 0

func add_items():
	var_option_button.add_item("(i = 0;")
	var_option_button.add_item("(i = 1;")
	var_option_button.add_item("(i = 2;")
	var_option_button.add_item("(i = 3;")
	
	condition_opt_btn.add_item("i > 7;")
	condition_opt_btn.add_item("i == 7;")
	condition_opt_btn.add_item("i < 7;")
	condition_opt_btn.add_item("i <= 7;")
	
	var_update_btn.add_item("i++)")
	var_update_btn.add_item("i--)")
	var_update_btn.add_item(")")
	

func _on_option_button_item_selected(index):
	valor_de_i = index


func _on_close_btn_pressed():
	await camera.reset_camera()
	State.set_interagindo(false)
	queue_free()


func _on_run_btn_pressed():
	
	if condicao == ">" or condicao == "=":
		aviso.text = "Esse código nunca é executado devido as condições, tome cuidado!"
		return
		
	if incremento == 0 or incremento == -1:
		aviso.text = "Esse código causa loop infinito, tome cuidado!"
		return
		
	if condicao == "<=":
		posicao_final = State.current_npc.bridge_size + 1
	else:
		posicao_final = State.current_npc.bridge_size
		
		
	if !await map.build_bridge(State.current_npc, valor_de_i, posicao_final):
		State.start_ballon(State.current_npc.dialogue_file, "falhou")
	else:
		hide()
		await camera.reset_camera()
		State.start_ballon(State.current_npc.dialogue_file, "sucesso")
		State.set_interagindo(false)
		queue_free()
		
	


func _on_condit_opt_btn_item_selected(index):
	
	
	if index == 0:
		condicao = ">"
	elif index == 1:
		condicao = "="
	elif index == 2:
		condicao = "<"
	elif index == 3:
		condicao = "<="


func _on_var_update_btn_item_selected(index):
	print(index)
	if index == 0:
		incremento = 1
	elif index == 1:
		incremento = -1
	elif  index == 2:
		incremento = 0


