extends BaseState

@export_node_path var walk_node
@export_node_path var stopping_node
@export_node_path var jump_node
@export_node_path var fall_node

@onready var walk_state: BaseState = get_node(walk_node)
@onready var stopping_state: BaseState = get_node(stopping_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)

func enter() -> void:
	super()

func input(event: InputEvent) -> BaseState:
	if Input.is_action_pressed("input_left") or Input.is_action_pressed("input_right"):
		return walk_state
	
	elif Input.is_action_just_pressed("input_jump"):
		return jump_state
	
	return null

func physics_process(delta: float) -> BaseState:
	parentNode.velocity.y += parentNode.base_gravity
	parentNode.move_and_slide()

	if !parentNode.is_on_floor():
		return fall_state
	
	if parentNode.velocity.x != 0:
		return stopping_state
	
	return null
