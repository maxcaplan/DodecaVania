class_name Player extends CharacterBody2D

@export_category("Movement")
@export var base_gravity : = 8

@export_range(0, 1) var input_dead_zone : = 0.01

@export_subgroup("Ground")
@export var walk_speed : = 60
@export var walk_acceleration : = 20
@export var walk_turn_acceleration : = 20
@export var walk_friction : = 20

@export_subgroup("Jump")
@export var jump_force : = 100
@export var jump_forward_force : = 10
@export var jump_gravity : = 4
@export var short_jump_gravity : = 12
@export var jumpBufferTime : = 100
@export var coyoteTime : = 100

@export_subgroup("Air")
@export var air_acceleration : = 20
@export var air_friction : = 20
@export var fall_speed : = 80
@export var fast_fall_speed : = 120
@export var fast_fall_gravity : = 12

@onready var states: StateManager = $StateManager

# Timestamp for when the player was last on the floor
var lastOnFloor : = 0

# Timestamp for when the player was last inputed jump
var lastJumpInput : = 0

func _ready() -> void:
	# Set the players initial velocity to 0
	velocity = Vector2.ZERO

	# Initialize state machine with refrence to self
	states.init(self)

func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	# Update lastOnFloor time while on the floor
	if is_on_floor():
		lastOnFloor = Time.get_ticks_msec()

	states.physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	# Update lastJumpInput time when jump is pressed
	if Input.is_action_just_pressed("input_jump"):
		lastJumpInput = Time.get_ticks_msec()

	states.input(event)

