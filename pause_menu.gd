extends Control



func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

var state : bool = false

func pauseMenu():
	if state:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hide()
		get_tree().paused = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		show()
	
	state = !state
	
func _on_resume_pressed():
	pauseMenu()


func _on_quit_pressed():
	get_tree().quit()
