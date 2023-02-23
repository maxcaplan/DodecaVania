class_name PlayerMoveState extends BaseState

@export_node_path var idle_node
@export_node_path var walk_node
@export_node_path var stopping_node
@export_node_path var jump_node
@export_node_path var fall_node
@export_node_path var fast_fall_node

@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var stopping_state: BaseState = get_node(stopping_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var fast_fall_state: BaseState = get_node(fast_fall_node)

var gravity: float
var fall_speed: float

func enter() -> void:
	super()
	gravity = parentNode.base_gravity
	fall_speed = parentNode.fall_speed

func exit() -> void:
	super()
	gravity = parentNode.base_gravity
	fall_speed = parentNode.fall_speed

func physics_process(delta: float) -> BaseState:
	apply_gravity(gravity, fall_speed)
	return null

func apply_gravity(gravity: float, max_speed: float = -1) -> void:
	if(parentNode.velocity.y < max_speed or max_speed < 0):
		parentNode.velocity.y += gravity

func apply_acceleration(direction: float, delta: float) -> void:
	var from = parentNode.velocity.x
	var to = parentNode.walk_speed * direction
	parentNode.velocity.x = move_toward(from, to, delta)

func apply_friction(delta) -> void:
	var from = parentNode.velocity.x
	parentNode.velocity.x = move_toward(from, 0, delta)
