extends CharacterBody2D
@export var speed = 200
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	
	

func _physics_process(delta):
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.animation = "walk_right"
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.animation = "walk_left"
		
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite2D.animation = "walk_up"
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.animation = "walk_down"
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		print(velocity)
	else:
		$AnimatedSprite2D.stop()
		
	move_and_slide()


