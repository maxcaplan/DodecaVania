extends PlayerAirMoveState

func enter() -> void:
	super()
	gravity = parentNode.jump_gravity
	parentNode.velocity.y = -parentNode.jump_force

	var forwardVelocity = clampf(absf(parentNode.velocity.x), 0, 1) * parentNode.jump_forward_force
	parentNode.velocity.x += forwardVelocity * inputDirection

func physics_process(delta: float) -> BaseState:
	parentNode.move_and_slide()

	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	if abs(inputDirection) > parentNode.input_dead_zone:
		apply_acceleration(inputDirection, parentNode.air_acceleration)
	else:
		apply_friction(parentNode.air_friction)

	if !Input.is_action_pressed("input_jump"):
		gravity = parentNode.short_jump_gravity

	if parentNode.velocity.y >= 0:
		return fall_state

	return null
