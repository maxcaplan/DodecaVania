extends PlayerMoveState

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("input_jump"):
		return jump_state
	
	return null

func physics_process(delta: float) -> BaseState:
	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state
	
	if !parentNode.is_on_floor():
		return fall_state

	var direction = Input.get_axis("input_left", "input_right")
	
	if abs(direction) > parentNode.input_dead_zone:
		return walk_state
	
	apply_friction(parentNode.walk_friction)
	parentNode.move_and_slide()
	
	if parentNode.velocity.x == 0:
		return idle_state

	return null
