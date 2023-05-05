class_name PlayerCamera extends Camera2D

@export var current_room : Room
@export var player : Player

@onready var offset_x_timer: Timer = $XOffsetTimer
@onready var offset_y_timer: Timer = $YOffsetTimer

@export_group("Camera Offset")

## The horizontal offset of the camera while moving
@export var offset_x : = 0.
## The vertical offset of the camera when holding up or down
@export var offset_y : = 0.
## The speed that x_offset changes by
@export var offset_x_delta : = 1.
## The speed that y_offset changes by
@export var offset_y_delta : = 1.
## The delay before x_offset is applied
@export var offset_x_delay : = 0.
## The delay before y_offset is applied
@export var offset_y_delay : = 0.

var camOffset : = Vector2.ZERO

var is_offseting_x : = false
var is_offseting_y : = false

func init() -> void:
	var cameraAreaRec = current_room.player_camera_area.get_collision_shape_rect()
	if cameraAreaRec.get_area() != 0: update_camera_limit(cameraAreaRec)

	position = player.position
	reset_smoothing()

func _physics_process(delta: float) -> void:
	var inputDir: Vector2
	inputDir.x = Input.get_axis("input_left", "input_right")
	inputDir.y = Input.get_axis("input_down", "input_up")

	update_offset_timers(inputDir)

	update_camera_offset(delta, inputDir)

	position = player.position + camOffset

func update_camera_limit(rect: Rect2):
	var viewportRect = get_viewport_rect()

	if viewportRect.size.x > rect.size.x:
		rect.position.x = rect.get_center().x - viewportRect.size.x / 2
		rect.size.x = viewportRect.size.x

	if viewportRect.size.y > rect.size.y:
		rect.position.y = rect.get_center().y - viewportRect.size.y / 2
		rect.size.y = viewportRect.size.y

	limit_left = rect.position.x
	limit_right = rect.end.x
	limit_top = rect.position.y
	limit_bottom = rect.end.y

func update_offset_timers(inputDir: Vector2) -> void:
	if inputDir.x != 0 and offset_x_timer.is_stopped() and not is_offseting_x:
		if offset_x_delay > 0.05:
			offset_x_timer.start(offset_x_delay)

	if inputDir.x == 0 and not offset_x_timer.is_stopped():
		offset_x_timer.stop()
		is_offseting_x = false

	if inputDir.y != 0 and offset_y_timer.is_stopped() and not is_offseting_y:
		if offset_y_delay > 0.05:
			offset_y_timer.start(offset_y_delay)

	if inputDir.y == 0 and not offset_y_timer.is_stopped():
		offset_y_timer.stop()
		is_offseting_y = false

func update_camera_offset(delta: float, inputDir: Vector2) -> void:
	var targetOffset = calc_camera_offset(inputDir)
	camOffset.x = lerpf(camOffset.x, targetOffset.x, offset_x_delta * delta)
	camOffset.y = lerpf(camOffset.y, targetOffset.y, offset_y_delta * delta)

func calc_camera_offset(inputDir: Vector2) -> Vector2:
	var offset : Vector2

	if is_offseting_x or offset_x_delay < 0.05:
		offset.x = signf(player.velocity.x) * offset_x

	if is_offseting_y or offset_y_delay < 0.05:
		# Only apply y offset if player isn't moving
		if player.velocity.length() == 0:
			offset.y = -signf(inputDir.y) * offset_y

	return offset

func _on_x_offset_timer_timeout() -> void:
	is_offseting_x = true

func _on_y_offset_timer_timeout() -> void:
	is_offseting_y = true
