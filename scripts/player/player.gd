class_name Player extends CharacterBody2D

@export_category("Movement")
@export var gravity : = 8

@export var jump_speed : = 100
@export_range(0, 1) var input_dead_zone : = 0.1

@export_subgroup("Walk")
@export var walk_speed : = 60
@export var walk_acceleration : = 20
@export var walk_turn_acceleration : = 20
@export var walk_friction : = 20

@onready var states: StateManager = $StateManager

func _ready() -> void:
	# Set the players initial velocity to 0
	velocity = Vector2.ZERO
	
	# Initialize state machine with refrence to self
	print_debug("initialize state manager")
	states.init(self)

func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

