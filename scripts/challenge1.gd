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
@onready var player = get_tree().get_root().get_node("Main/Player")

var tem_pt_e_virgula: String = ";"
var incremento := -1
var da_loop_infinito := false

var while_opt_btn_empty := true
var inc_opt_btn_empty := true

var posx
var posy

func _process(_delta):

	var screen_size = get_viewport().size
	var camera_pos = camera.get_screen_center_position()
	var topLeft = screen_size.y/4
	var challenge_x = camera_pos.x
	var challenge_y = camera_pos.y - topLeft
	
	if posx != challenge_x or posy != challenge_y:
		position = Vector2(challenge_x, challenge_y)
		posx = challenge_x
		posy = challenge_y	
		
func _ready():
	add_items()
	aviso.text = ""

func add_items():
	while_option_button.add_item(" ")
	while_option_button.add_item("(i <= 7);")
	while_option_button.add_item("(i <= 7)")
	while_option_button.add_item("(i < 8)")
	while_option_button.add_item("(1 < 8)")
	while_option_button.add_item("(i = 8)")
	
	inc_opt_btn.add_item(" ")
	inc_opt_btn.add_item("i--;")
	inc_opt_btn.add_item("i++;")



func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()
	
func disableBtns():
	while_option_button.disable()
	inc_opt_btn.disable()
	run_btn.disabled = true
	close_btn.disabled = true

func enableBtns():
	while_option_button.enable()
	inc_opt_btn.enable()
	run_btn.disabled = false
	close_btn.disabled = false
	
func _on_run_btn_pressed():
	
	aviso.hide()
	
	if while_opt_btn_empty or inc_opt_btn_empty:
		aviso.text = "Não é possível executar o código sem escolher uma opção para os botões!"
		aviso.show()
		return
		
	if tem_pt_e_virgula == ";": 
		aviso.text = "Erro de laço infinito! Lembre-se que não deve existir ponto e vírgula após a condição do laço while."
		if incremento == -1:
			aviso.text += " Além disso, atenção na atualização do valor da variável ‘i’ na linha 7."
		
		aviso.text += " Tente novamente!"
		aviso.show()
		da_loop_infinito = true
		return
		
	if tem_pt_e_virgula == "<": 
		aviso.text = "Erro de laço infinito! A condição (1 < 8) sempre é verdadeira."
		aviso.show()
		da_loop_infinito = true
		
	if tem_pt_e_virgula == "=": 
		aviso.text = "Erro de laço infinito! O operador ‘=’ está atribuindo um valor a variável ‘i’ na linha 4."
		aviso.show()
		da_loop_infinito = true
		
	var ini_cerca = 2
	var fim_cerca = 7
		
		
	if incremento == 1 and da_loop_infinito:
		aviso.show()
		fim_cerca = 15
		
	if incremento == -1:
		if tem_pt_e_virgula == "":
			aviso.text = "Erro de laço infinito! Atenção na atualização do valor da variável ‘i’."
		else:
			aviso.text += " Além disso, atenção na atualização do valor da variável ‘i’ na linha 7."
		aviso.show()
		fim_cerca = -12
		da_loop_infinito = true
		
	# Se da loop infinito está errado 
	if da_loop_infinito:
		aviso.text += " Tente novamente!"
		disableBtns()
		player.inc_ms_inf_loop()
		await map.build_fence(ini_cerca, fim_cerca, incremento)
		enableBtns()
		map.remove_fence()
		da_loop_infinito = false # temos que sempre recarregar essa variavel
		return
	else:
		aviso.text = "Parabéns! Você conseguiu!"
		aviso.show()
		aviso.add_theme_color_override("font_color", Color.GREEN)
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


func _on_inc_option_option_selected(index):
	if index == 0:
		inc_opt_btn_empty = true
		return
	elif index == 1:
		incremento = -1
	elif index == 2:
		incremento = 1
	
	inc_opt_btn_empty = false


func _on_while_option_option_selected(index):
	if index == 0:
		while_opt_btn_empty = true
		return
	elif index == 1:
		tem_pt_e_virgula = ";"
	elif index == 2:
		tem_pt_e_virgula = ""
	elif index == 3:
		tem_pt_e_virgula = ""
	elif index == 4:
		tem_pt_e_virgula = "<"
	elif index == 5:
		tem_pt_e_virgula = "="
		
	while_opt_btn_empty = false

