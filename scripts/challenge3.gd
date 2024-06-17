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

var opc1 : String = "||"
var opc2 : String = "&&"
var opc3 : String = "  "

func _ready():
	add_items()
	aviso.text = ""

func add_items():
	while_option_button.add_item("||")
	while_option_button.add_item("&&")
	
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
	
	if (opc3 != " !"):
		aviso.text = "Precisamos preparar a terra antes do plantio!"
		aviso.show()
		return
	
	if (opc1 == "&&" and opc2 == "&&"):
		aviso.add_theme_color_override("font_color", Color.GREEN)
		aviso.text = "Você conseguiu!"
		aviso.show()
		disableBtns()
		await map.plant(8, true)
		await camera.reset_camera()
		enableBtns()
		State.finaliza_interacao()
		State.current_npc.challenge_passed = true
		State.current_npc.ponto_excl.hide()
		queue_free()
	
	elif (opc1 == "&&" and opc2 == "||"):
		aviso.text = "Serão plantadas sementes até que ambas cheguem a valores negativos, ocupando o terreno inteiro!"
		aviso.show()
		disableBtns()
		await map.plant(8, false)
		enableBtns()
		return
		
	elif (opc1 == "||" and opc2 == "&&"):
		aviso.text = "Dessa forma a semente de milho chega a um valor negativo!"
		aviso.show()
		disableBtns()
		await map.plant(7, false)
		enableBtns()
		return
		
	elif (opc1 == "||" and opc2 == "||"):
		aviso.text = "Serão plantadas sementes até que ambas cheguem a valores negativos, ocupando o terreno inteiro!"
		aviso.show()
		disableBtns()
		await map.plant(8, false)
		enableBtns()
		return
	



func _on_while_option_2_option_selected(index):
	if index == 0:
		opc2 = "&&"
	elif index == 1:
		opc2 = "||"


func _on_while_option_option_selected(index):
	if index == 0:
		opc1 = "||"
	elif index == 1:
		opc1 = "&&"


func _on_if_option_option_selected(index):
	if index == 0:
		opc3 = "  "
	elif index == 1:
		opc3 = " !"

