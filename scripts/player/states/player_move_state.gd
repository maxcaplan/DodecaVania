class_name PlayerMoveState extends BaseState

@export_node_path var idle_node
@export_node_path var walk_node
@export_node_path var stopping_node
@export_node_path var jump_node
@export_node_path var fall_node

@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var stopping_state: BaseState = get_node(stopping_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)

func physics_process(delta: float) -> BaseState:
	apply_gravity()
	return null

func apply_gravity() -> void:
	parentNode.velocity.y += parentNode.gravity

func apply_acceleration(direction: float, delta: float) -> void:
	var from = parentNode.velocity.x
	var to = parentNode.walk_speed * direction
	parentNode.velocity.x = move_toward(from, to, delta)

func apply_friction(delta) -> void:
	var from = parentNode.velocity.x
	parentNode.velocity.x = move_toward(from, 0, delta)
