extends Control

@onready var option_button = $MarginContainer/Panel/OptionButton

var for_code = "#include <stdio.h>

			int main(void)
			{
				int i;
				for ...
					colocar_tabuas(); 
			}"


func _ready():
	add_items()
	$MarginContainer/Panel/CodeEdit.text = for_code


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
		print("selecionou 2o")
	if selected == 3:
		print("selecionou 3o")
