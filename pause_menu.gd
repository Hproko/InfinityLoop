extends Control

@onready var player_animation = $"../AnimatedSprite2D"

var _is_paused: bool = false:
	set = set_paused
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_is_paused = !_is_paused
		
		
func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	
	if _is_paused:
		player_animation.stop()


	
func _on_resume_pressed():
	_is_paused = false


func _on_quit_pressed():
	get_tree().quit()
