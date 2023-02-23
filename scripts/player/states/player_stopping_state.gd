extends PlayerGroundMoveState

func physics_process(delta: float) -> BaseState:
	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	if abs(inputDirection) > parentNode.input_dead_zone:
		return walk_state

	apply_friction(parentNode.walk_friction)
	parentNode.move_and_slide()

	if parentNode.velocity.x == 0:
		return idle_state

	return null
