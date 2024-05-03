extends Camera2D

# Velocidade de movimento da câmera
var camera_speed = 6
var pos_x_orig = position.x
var pos_y_orig = position.y
	
func move_camera_left():
	for i in range (1, 30):
		position.x += camera_speed
		await get_tree().create_timer(0.1).timeout
	
		
func reset_camera():
	position.x = pos_x_orig
	position.y = pos_y_orig
