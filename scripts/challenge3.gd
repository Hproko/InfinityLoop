extends Control

@onready var while_option_button = %WhileOption
@onready var while_option_button2 = %WhileOption2
@onready var run_btn = %RunBtn
@onready var close_btn = %CloseBtn
@onready var code_edit = %CodeEdit
@onready var map = $'../map'
@onready var aviso = %Aviso
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var screen_size = get_viewport().size

var opc1 : String = "||"
var opc2 : String = "&&"

func _ready():
	add_items()
	aviso.text = ""

func add_items():
	while_option_button.add_item("||")
	while_option_button.add_item("&&")
	
	while_option_button2.add_item("&&")
	while_option_button2.add_item("||")
	

func _on_close_btn_pressed():
	await camera.reset_camera()
	State.finaliza_interacao()
	queue_free()
	
func disableBtns():
	while_option_button.disabled = true
	run_btn.disabled = true
	close_btn.disabled = true

func enableBtns():
	while_option_button.disabled = false
	run_btn.disabled = false
	close_btn.disabled = false
	
func _on_run_btn_pressed():
	
	aviso.hide()
	
	if (opc1 == "&&" and opc2 == "&&"):
		aviso.add_theme_color_override("font_color", Color.GREEN)
		aviso.text = "Você conseguiu!"
		aviso.show()
		await camera.reset_camera()
		State.finaliza_interacao()
		State.current_npc.challenge_passed = true
		State.current_npc.ponto_excl.hide()
		queue_free()
	
	elif (opc1 == "&&" and opc2 == "||"):
		aviso.text = "Dessa forma a semente de milho chega a um valor negativo, e iremos iterar até extrapolar o limite de terreno."
		aviso.show()
		return
		
	elif (opc1 == "||" and opc2 == "&&"):
		aviso.text = "Dessa forma a semente de milho chega a um valor negativo, e iremos iterar até extrapolar o limite de terreno."
		aviso.show()
		return
		
	elif (opc1 == "||" and opc2 == "||"):
		aviso.text = "Serão plantadas sementes até que ambas cheguem a valores negativos, extrapolando o limite de terreno."
		aviso.show()
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
