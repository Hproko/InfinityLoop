extends Control

@onready var while_option_button = %WhileOption
@onready var while_option_button2 = %WhileOption2
@onready var if_option = %IfOption
@onready var run_btn = %RunBtn
@onready var close_btn = %CloseBtn
@onready var code_edit = %CodeEdit
@onready var map = $'../map'
@onready var aviso = %Aviso
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var screen_size = get_viewport().size
@onready var player = get_tree().get_root().get_node("Main/Player")

var opc1 : String = "||"
var opc2 : String = "&&"
var opc3 : String = "  "
var while1_opt_btn_empty := true
var while2_opt_btn_empty := true

	
func _ready():
	add_items()
	aviso.text = ""

func add_items():
	while_option_button.add_item(" ")
	while_option_button.add_item("||")
	while_option_button.add_item("&&")
	
	while_option_button2.add_item(" ")
	while_option_button2.add_item("&&")
	while_option_button2.add_item("||")
	
	if_option.add_item("  ")
	if_option.add_item(" !")
	

func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()
	
func disableBtns():
	while_option_button.disable()
	while_option_button2.disable()
	if_option.disable()
	run_btn.disabled = true
	close_btn.disabled = true
	

func enableBtns():
	run_btn.disabled = false
	close_btn.disabled = false
	while_option_button.enable()
	while_option_button2.enable()
	if_option.enable()
	
func _on_run_btn_pressed():
	aviso.hide()
	
	if while1_opt_btn_empty or while2_opt_btn_empty:
		aviso.text = "É necessário escolher uma opção para os botões dentro do WHILE para executar o código!"
		aviso.show()
		return
		
	#if (opc3 != " !"):
		#aviso.text = "Precisamos preparar a terra antes do plantio!"
		#player.inc_ms_rel_logic()
		#aviso.show()
		#return
	
	if (opc1 == "&&" and opc2 == "&&"):
		aviso.add_theme_color_override("font_color", Color.GREEN)
		aviso.text = "Parabéns! Você conseguiu!"
		aviso.show()
		disableBtns()
		await map.plant(5, true)
		await get_tree().create_timer(2).timeout
		await camera.reset_camera()
		enableBtns()
		State.finaliza_interacao()
		State.current_npc.challenge_passed = true
		State.current_npc.ponto_excl.hide()
		queue_free()
	
	elif (opc1 == "&&" and opc2 == "||"):
		aviso.text = "Uso incorreto do operador lógico.Você tem 5 sementes de milho e 7 sementes de trigo e está tentando plantar 8 de cada. Tente novamente!"
		aviso.show()
		player.inc_ms_rel_logic()
		disableBtns()
		await map.plant(8, false)
		enableBtns()
		return
		
	elif (opc1 == "||" and opc2 == "&&"):
		aviso.text = "Uso incorreto do operador lógico. Você tem 5 sementes de milho e está tentando plantar 7. Tente novamente!"
		aviso.show()
		player.inc_ms_rel_logic()
		disableBtns()
		await map.plant(7, false)
		enableBtns()
		return
		
	elif (opc1 == "||" and opc2 == "||"):
		aviso.text = "Uso incorreto do operador lógico. Você tem 5 sementes de milho e 7 sementes de trigo e está tentando plantar 8 de cada. Tente novamente!"
		aviso.show()
		player.inc_ms_rel_logic()
		disableBtns()
		await map.plant(8, false)
		enableBtns()
		return
	



func _on_while_option_2_option_selected(index):
	if index == 0:
		while2_opt_btn_empty = true
		return
	elif index == 1:
		opc2 = "&&"
	elif index == 2:
		opc2 = "||"
		
	while2_opt_btn_empty = false


func _on_while_option_option_selected(index):
	if index == 0:
		while1_opt_btn_empty = true
		return
	elif index == 1:
		opc1 = "||"
	elif index == 2:
		opc1 = "&&"
	
	while1_opt_btn_empty = false


func _on_if_option_option_selected(index):
	if index == 0:
		opc3 = "  "
	elif index == 1:
		opc3 = " !"

