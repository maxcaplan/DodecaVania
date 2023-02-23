@tool
class_name StateManager extends Node

@export_node_path("Node") var starting_state

@export_placeholder("state name") var current_state_name:
	get: return current_state.name

var current_state: BaseState

# Transitions from the current state to a provided new state
func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

# Initializes the state machine and all of it's state nodes
func init(parentNode: Node) -> void:
	# Pass a refrence of the parent node that the state should control
	# to all state nodes
	for child in get_children():
		child.parentNode = parentNode

	# Set the starting state of the state machine
	change_state(get_node(starting_state))


# Pass through functions for the parent node to call
# handels state change when needed

func process(delta: float) -> void:
	var new_state = current_state.process(delta)

	if new_state:
		change_state(new_state)

func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)

	if new_state:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)

	if new_state:
		change_state(new_state)
