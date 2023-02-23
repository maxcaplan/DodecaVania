extends PlayerGroundMoveState

func physics_process(delta: float) -> BaseState:
	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	var direction = Input.get_axis("input_left", "input_right")
	var velocityDirecton = signf(parentNode.velocity.x)

	if abs(direction) <= parentNode.input_dead_zone:

		if parentNode.velocity.x == 0:
			return idle_state
		else:
			return stopping_state

	if sign(direction) == velocityDirecton or velocityDirecton == 0:
		apply_acceleration(direction, parentNode.walk_acceleration)
	else:
		apply_acceleration(direction, parentNode.walk_turn_acceleration)

	parentNode.move_and_slide()

	return null
