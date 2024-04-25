extends Control

@onready var option_button = %OptionButton
@onready var code_edit = %CodeEdit
@onready var map = $'../../map'

func _ready():
	add_items()


func add_items():
	option_button.add_item("for(i = 0; i > 10; i--)")
	option_button.add_item("for(i = 10; i >= 10; i++)")
	option_button.add_item("for(i = 0; i < 10; i++)")
	option_button.add_item("for(i = 0; i < 10; i--)")

func _on_option_button_item_selected(index):
	var selected = index
	if selected == 0:
		print("selecionou zero")
	if selected == 1:
		print("selecionou 1o")
	if selected == 2:
		hide()
		map.build_bridge(State.current_npc, 7)
		State.set_interagindo(false)
		print("selecionou 2o")
	if selected == 3:
		print("selecionou 3o")


func _on_close_btn_pressed():
	hide()
	State.set_interagindo(false)
