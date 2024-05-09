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
	
	condition_opt_btn.add_item("i > 4;")
	condition_opt_btn.add_item("i == 4;")
	condition_opt_btn.add_item("i < 4;")
	condition_opt_btn.add_item("i <= 4;")
	
	var_update_btn.add_item("i++)")
	var_update_btn.add_item("i--)")
	var_update_btn.add_item(")")
	

func _on_option_button_item_selected(index):
	valor_de_i = index


func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()


func _on_run_btn_pressed():
	
	if condicao == ">" or condicao == "=":
		aviso.text = "Esse código nunca é executado devido as condições, tome cuidado!"
		return
		
	if incremento == 0 or incremento == -1:
		aviso.text = "Esse código causa loop infinito, tome cuidado!"
		return
		
	# Para entrar no range (ini, fim) pra executar ultima iteracao deve ter +1
	if condicao == "<=":
		posicao_final = 5
	else:
		posicao_final = 4
		
		
	if !await map.build_fence(valor_de_i, posicao_final):
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


