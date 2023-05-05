class_name Room extends Node2D

var spawn_points: Array[Node2D]

@export var player_camera_area: CameraArea2D

func _ready() -> void:
	var spawnNodes = get_node("Spawns").get_children()
	for node in spawnNodes:
		if node is Node2D: spawn_points.push_back(node)
