extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$message.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_message(text):
	$message.text = text
	$message.show()
	
func hide_message():
	$message.hide()
