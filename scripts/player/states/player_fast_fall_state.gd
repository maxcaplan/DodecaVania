extends PlayerMoveState

func enter() -> void:
	super()
	gravity = parentNode.fast_fall_gravity
	fall_speed = parentNode.fast_fall_speed

func physics_process(delta: float) -> BaseState:
	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state
	
	var direction = Input.get_axis("input_left", "input_right")
	
	if abs(direction) > parentNode.input_dead_zone:
		apply_acceleration(direction, parentNode.air_acceleration)
	else:
		apply_friction(parentNode.air_friction)
	
	parentNode.move_and_slide()
	
	if parentNode.is_on_floor():
		if abs(direction) >= parentNode.input_dead_zone:
			return walk_state
		if parentNode.velocity.x > 0:
			return stopping_state
		
		return idle_state
	
	if !Input.is_action_pressed("input_down"):
		return fall_state
	
	return null
