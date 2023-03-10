class_name CameraArea2D extends Area2D

@onready var collision_shape_2d: CollisionShape2D = get_node("CollisionShape2D")

## Returns a Rect2 representing CameraArea2Ds bounding box
## Returns a Rect2 with area 0 if no collision shape is found on CameraArea2D
func get_collision_shape_rect() -> Rect2:
	if !collision_shape_2d: return Rect2(Vector2.ZERO, Vector2.ZERO)
	if !collision_shape_2d.shape: return Rect2(Vector2.ZERO, Vector2.ZERO)

	var cameraAreaRec =  collision_shape_2d.shape.get_rect()

	# Offset rec by collision shape position to get global cords
	cameraAreaRec.position.x += collision_shape_2d.position.x
	cameraAreaRec.position.y += collision_shape_2d.position.y

	return cameraAreaRec
