class_name PlayerGroundMoveState
extends PlayerMoveState

func input(event: InputEvent) -> BaseState:
	# Run super class input method and change state if needed
	var new_state = super(event)
	if new_state: return new_state

	var currentTime = Time.get_ticks_msec()
	var lastJumpInputDeltaTime = currentTime - parentNode.lastJumpInput

	if lastJumpInputDeltaTime <= parentNode.jumpBufferTime:
		return jump_state

	return null

func physics_process(delta: float) -> BaseState:
	# Run super class physics process method and change state if needed
	var new_state = super(delta)
	if new_state: return new_state

	if !parentNode.is_on_floor():
		return fall_state

	return null
