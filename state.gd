extends Node

var interagindo : bool = false


func set_interagindo(value):
	interagindo = value

func finaliza_interacao():
	interagindo = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func get_interagindo():
	return interagindo
