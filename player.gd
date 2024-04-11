extends CharacterBody2D
@export var speed = 200

@onready var interactLabel = $"Interaction component/InteractLabel"
@onready var main = get_parent()
@onready var tile_map = main.get_node('map')
@onready var all_interactions = []

var screen_size
var interagiu : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	

func _physics_process(_delta):

	velocity = Vector2.ZERO

	if Input.is_action_just_pressed("Interact"):
		execute_interaction()
	
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
		

func execute_interaction():
	if all_interactions:
		var npc = all_interactions[0]
		interactLabel.text = ""
		if npc.bridge_builded == false:
			DialogueManager.show_example_dialogue_balloon(load(npc.dialogue_file), "start")
			npc.bridge_builded = true
			tile_map.build_bridge(npc, 7)
		else:
			DialogueManager.show_example_dialogue_balloon(load(npc.dialogue_file), "finish")
