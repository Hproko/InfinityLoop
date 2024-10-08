extends CharacterBody2D
@export var speed = 200

@onready var main = get_parent()
@onready var tile_map = main.get_node('map')
@onready var all_interactions = []
#@onready var challenge = $Challenge
@onready var instr = $Instrucao


var miss_cncptn_pos_invalid := 0
var miss_cncptn_inf_loop := 0
var miss_cncptn_rel_oper := 0
var miss_cncptn_rel_logic := 0

func inc_ms_pos_invalid():
	miss_cncptn_pos_invalid += 1

func inc_ms_inf_loop():
	miss_cncptn_inf_loop += 1
	
func inc_ms_rel_oper():
	miss_cncptn_rel_oper += 1

func inc_ms_rel_logic():
	miss_cncptn_rel_logic += 1


func _physics_process(_delta):

	
	velocity = Vector2.ZERO

	if State.get_interagindo():
		$AnimatedSprite2D.stop()
		return
	
	if Input.is_action_just_pressed("Interact"):
		execute_interaction()
		$AnimatedSprite2D.stop()
		
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite2D.play("walk_up")
		instr.hide()
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.play("walk_down")
		instr.hide()
		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		instr.hide()
		if velocity.y == 0:
			$AnimatedSprite2D.play("walk_right")
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		instr.hide()
		if velocity.y == 0:
			$AnimatedSprite2D.play("walk_left")
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.stop()
		
	move_and_slide()




func _on_interaction_area_area_entered(area):
	# esse parametro area que entra aqui é o npc
	all_interactions.insert(0, area)
	area.interact_message.show()


func _on_interaction_area_area_exited(area):
	# esse parametro area que entra aqui é o npc
	all_interactions.erase(area)
	area.interact_message.hide()



func execute_interaction():
	
	# Esse if detecta se o NPC ta na área do personagem
	if all_interactions:
		var npc = all_interactions[0]
		State.set_current_npc(npc)
		
		State.set_interagindo(true)
		
		if npc.challenge_passed == false:
			npc.interact_message.hide()
			$AnimatedSprite2D.stop()
			State.start_ballon(npc.dialogue_file, "start")
		else:
			State.start_ballon(npc.dialogue_file, "finish")
