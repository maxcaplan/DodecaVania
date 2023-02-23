extends PlayerAirMoveState

func enter() -> void:
	super()
	gravity = parentNode.base_gravity
	fall_speed = parentNode.fall_speed

func physics_process(delta: float) -> BaseState:
	# Run move super class state and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	var currentTime = Time.get_ticks_msec()
	var lastOnFloorDeltaTime = currentTime - parentNode.lastOnFloor
	var lastJumpInputDeltaTime = currentTime - parentNode.lastJumpInput

	if lastOnFloorDeltaTime <= parentNode.coyoteTime:
		if lastJumpInputDeltaTime <= parentNode.jumpBufferTime:
			print("coyote jump")
			return jump_state


	if abs(inputDirection) > parentNode.input_dead_zone:
		apply_acceleration(inputDirection, parentNode.air_acceleration)
	else:
		apply_friction(parentNode.air_friction)

	if Input.is_action_pressed("input_down") and parentNode.velocity.y >= 0:
		return fast_fall_state

	parentNode.move_and_slide()

	return null
