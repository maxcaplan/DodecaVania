extends PlayerAirMoveState

func enter() -> void:
	super()
	gravity = parentNode.fast_fall_gravity
	fall_speed = parentNode.fast_fall_speed

func physics_process(delta: float) -> BaseState:
	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	if abs(inputDirection) > parentNode.input_dead_zone:
		apply_acceleration(inputDirection, parentNode.air_acceleration)
	else:
		apply_friction(parentNode.air_friction)

	if !Input.is_action_pressed("input_down"):
		return fall_state

	parentNode.move_and_slide()

	return null
