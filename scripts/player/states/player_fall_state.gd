extends PlayerMoveState

func physics_process(delta: float) -> BaseState:
	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state
	
	var direction = Input.get_axis("input_left", "input_right")
	
	if abs(direction) > parentNode.input_dead_zone:
		apply_acceleration(direction, parentNode.walk_acceleration)
	else:
		apply_friction(parentNode.walk_friction)
	
	parentNode.move_and_slide()
	
	if parentNode.is_on_floor():
		if abs(direction) >= parentNode.input_dead_zone:
			return walk_state
		if parentNode.velocity.x > 0:
			return stopping_state
		
		return idle_state
	
	return null
