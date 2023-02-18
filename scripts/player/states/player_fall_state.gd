extends BaseState

@export_node_path var idle_node
@export_node_path var walk_node
@export_node_path var jump_node

@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var jump_state: BaseState = get_node(jump_node)

func physics_process(delta: float) -> BaseState:
	var direction = Input.get_axis("input_left", "input_right")
	
	parentNode.velocity.y += parentNode.gravity
	parentNode.velocity.x = parentNode.move_speed * direction
	parentNode.move_and_slide()
	
	if parentNode.is_on_floor():
		if abs(direction) < parentNode.input_dead_zone:
			return idle_state
		else:
			return walk_state
	
	return null
