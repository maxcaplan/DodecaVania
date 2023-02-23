extends PlayerGroundMoveState

func input(event: InputEvent) -> BaseState:
	# Run super class input method and change state if needed
	var new_state = super(event)
	if new_state: return new_state

	if Input.is_action_pressed("input_left") or Input.is_action_pressed("input_right"):
		return walk_state

	return null

func physics_process(delta: float) -> BaseState:
	# Run super class physics process method and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	if parentNode.velocity.x != 0:
		return stopping_state

	parentNode.move_and_slide()

	return null
