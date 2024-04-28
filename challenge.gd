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
	State.set_primeira_vez(false)
	var selected = index
	if selected == 0:
		State.set_passou_desafio(false)
	if selected == 1:
		State.set_passou_desafio(false)
	if selected == 2:
		hide()
		map.build_bridge(State.current_npc, 7)
		State.set_interagindo(false)
		State.set_passou_desafio(true)
	if selected == 3:
		State.set_passou_desafio(false)


func _on_close_btn_pressed():
	hide()
	State.set_interagindo(false)
