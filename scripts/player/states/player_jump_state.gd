extends BaseState

@export_node_path var idle_node
@export_node_path var walk_node
@export_node_path var fall_node

@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var fall_state: BaseState = get_node(fall_node)

func enter() -> void:
	super()
	
	parentNode.velocity.y = -parentNode.jump_speed

func physics_process(delta: float) -> BaseState:
	var direction = Input.get_axis("input_left", "input_right")
	
	parentNode.velocity.y += parentNode.gravity
	parentNode.velocity.x = parentNode.move_speed * direction
	parentNode.move_and_slide()
	
	if parentNode.velocity.y < 0:
		return fall_state
	
	if parentNode.is_on_floor():
		if abs(direction) < parentNode.input_dead_zone:
			return idle_state
		else:
			return walk_state
	
	return null
