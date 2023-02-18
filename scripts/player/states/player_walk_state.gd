extends BaseState

@export_node_path var idle_node
@export_node_path var jump_node
@export_node_path var fall_node

@onready var idle_state: BaseState = get_node(idle_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("input_jump"):
		return jump_state
	
	return null

func physics_process(delta: float) -> BaseState:
	if !parentNode.is_on_floor():
		return fall_state

	var direction = Input.get_axis("input_left", "input_right")
	
	parentNode.velocity.y += parentNode.gravity
	parentNode.velocity.x = parentNode.move_speed * direction
	parentNode.move_and_slide()
	
	if abs(direction) < parentNode.input_dead_zone:
		return idle_state

	return null
