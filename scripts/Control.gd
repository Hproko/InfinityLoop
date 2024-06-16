extends Control

class_name MyOptnBtn

signal option_selected(index)

@export var font_size := 15
@onready var camera = get_tree().get_root().get_node("Main/Player/Camera")
@onready var custom_button = $VBoxContainer/Button
@onready var popup_menu = $VBoxContainer/PopupMenu

func disable():
	custom_button.disabled = true
	
func enable():
	custom_button.disabled = false
	

func get_minimum_button_size(button, strings):
	var font = custom_button.get_theme_default_font()
	var max_width = 0
	var max_height = 0
	
	# Itera por cada string para encontrar a largura e altura máximas
	for text in strings:
		var size = font.get_string_size(text)
		if size.x > max_width:
			max_width = size.x
		if size.y > max_height:
			max_height = size.y
	
	## Adiciona um pequeno padding para o botão
	#max_width += 8  # Ajuste o padding conforme necessário
	#max_height += 5

	return Vector2(max_width, max_height)
	
func add_item(text : String):
	popup_menu.add_item(text)
	custom_button.text = popup_menu.get_item_text(popup_menu.get_item_index(0))
	custom_button.custom_minimum_size = get_minimum_button_size(custom_button, get_popup_menu_items(popup_menu))

func get_popup_menu_items(popup_menu: PopupMenu):
	var items = []
	var item_count = popup_menu.get_item_count()
	for i in range(item_count):
		items.append(popup_menu.get_item_text(i))
	return items
	
func _ready():

	custom_button.add_theme_font_size_override("font_size", font_size)
	# Remove o ícone da seta do botão
	custom_button.icon = null
	


func _on_popup_menu_index_pressed(index):
	custom_button.text = popup_menu.get_item_text(popup_menu.get_item_index(index))
	emit_signal("option_selected", index)


func _on_button_pressed():
	# Exibe o PopupMenu na posição do botão
	popup_menu.set_position(custom_button.get_screen_position() + Vector2(0, custom_button.size.y))
	popup_menu.size = Vector2(custom_button.size.x, custom_button.size.y * popup_menu.item_count)
	popup_menu.popup()

