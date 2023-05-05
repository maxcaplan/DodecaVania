extends Node2D

@export var player : Player
@export var player_camera : PlayerCamera

@export_file('*.tscn') var starting_room

var current_room : Room

func _ready() -> void:
	current_room = load_room(starting_room)
	add_child(current_room)

	player.position = find_closest_spawn(current_room).position

	player_camera.current_room = current_room
	player_camera.init()

func load_room(path: String) -> Room:
	assert(path, "No path to room specified")
	assert(ResourceLoader.exists(path), "File " + path + " does not exist")

	return ResourceLoader.load(path).instantiate()

func find_closest_spawn(room: Room) -> Node2D:
	var closest_spawn: Node2D
	for spawn in room.spawn_points:
		if not closest_spawn:
			closest_spawn = spawn
			pass

		var dist = spawn.position.distance_to(player.position)
		var closest_dist = closest_spawn.position.distance_to(player.position)

		if dist < closest_dist:
			closest_spawn = spawn

	return closest_spawn

