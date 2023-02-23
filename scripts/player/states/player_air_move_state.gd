class_name PlayerAirMoveState
extends PlayerMoveState

func physics_process(delta: float) -> BaseState:
	# Run super class physics process method and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	if parentNode.is_on_floor():
		if abs(inputDirection) >= parentNode.input_dead_zone:
			return walk_state
		if parentNode.velocity.x > 0:
			return stopping_state

		return idle_state

	return null
