extends CharacterBody2D
@export var speed = 200

@onready var interactLabel = $"Interaction component/InteractLabel"
@onready var main = get_parent()
@onready var tile_map = main.get_node('map')
@onready var all_interactions = []
#@onready var challenge = $Challenge

	

func _physics_process(delta):

	
	velocity = Vector2.ZERO

	if State.get_interagindo():
		return
	
	if Input.is_action_just_pressed("Interact"):
		execute_interaction()
		$AnimatedSprite2D.stop()
		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.play("walk_right")

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.play("walk_left")
		
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite2D.play("walk_up")
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.play("walk_down")
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.stop()
		
	move_and_slide()




func _on_interaction_area_area_entered(area):
	# esse parametro area que entra aqui é o npc
	all_interactions.insert(0, area)
	update_interactions()



func _on_interaction_area_area_exited(area):
	# esse parametro area que entra aqui é o npc
	all_interactions.erase(area)
	update_interactions()


func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""
		#challenge.hide()
		

func execute_interaction():
	if all_interactions:
		
		var npc = all_interactions[0]
		State.set_current_npc(npc)
		
		interactLabel.text = ""
		
		if npc.challenge_passed == false:
			State.set_interagindo(true)
			$AnimatedSprite2D.stop()
			State.start_ballon(npc.dialogue_file, "start")
		else:
			State.start_ballon(npc.dialogue_file, "finish")