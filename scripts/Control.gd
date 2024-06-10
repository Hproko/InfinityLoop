extends Control

class_name MyOptBtn

signal option_selected(index)

@export var font_size := 15
@onready var custom_button = $VBoxContainer/Button
@onready var popup_menu = $VBoxContainer/PopupMenu

func add_item(text : String):
	popup_menu.add_item(text)
	custom_button.text = popup_menu.get_item_text(popup_menu.get_item_index(0))
	
func _ready():

	custom_button.add_theme_font_size_override("font_size", font_size)
	# Remove o ícone da seta do botão
	custom_button.icon = null




func _on_popup_menu_index_pressed(index):
	custom_button.text = popup_menu.get_item_text(popup_menu.get_item_index(index))
	emit_signal("option_selected", index)


func _on_button_pressed():
	# Exibe o PopupMenu na posição do botão
	popup_menu.set_position(custom_button.get_global_position() + Vector2(0, custom_button.size.y))
	popup_menu.size = Vector2(custom_button.size.x, custom_button.size.y * popup_menu.item_count)
	popup_menu.popup()

