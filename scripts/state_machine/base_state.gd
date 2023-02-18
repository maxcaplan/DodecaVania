# Generic state class for use with a state machine
class_name BaseState extends Node

@export var active : = false

# The node that the state is responsible for controling
var parentNode: Node

# Executes once when the state is first entered
func enter() -> void:
	active = true
	pass

# Executes once when the state is exited
func exit() -> void:
	active = false
	pass

# Handels inputed data for the state
func input(event: InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null
