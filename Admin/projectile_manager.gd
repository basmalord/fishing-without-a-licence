extends Node

class_name ProjectileManager

@export var projectile_paths: Array[String]

var projectile_packed_scenes: Array[PackedScene]

func _ready():
	load_projectiles(projectile_paths)

func get_player_position():
	if get_tree().get_first_node_in_group("Player") != null:
		var player = get_tree().get_first_node_in_group("Player")
		var player_global_position = player.global_position
		return player_global_position

func instantiate_projectile(enemy_projectile_path: String, enemy_global_position: Vector2, is_shotgun: bool = false):
	if projectile_paths.find(enemy_projectile_path) == -1:
		print("ERROR: COULD NOT FIND ENEMY PROJECTILE IN PROJECTILE MANAGER")
		return
	if !is_shotgun:
		var new_projectile_path_index = projectile_paths.find(enemy_projectile_path)
		var new_projectile_packed_scene = projectile_packed_scenes[new_projectile_path_index]
		var new_projectile = new_projectile_packed_scene.instantiate()
		add_child(new_projectile)
		new_projectile.global_position = enemy_global_position
		new_projectile.target = get_player_position()
		new_projectile.direction = (new_projectile.target - enemy_global_position).normalized()
	else:
		for n in 3:
			var new_projectile_path_index = projectile_paths.find(enemy_projectile_path)
			var new_projectile_packed_scene = projectile_packed_scenes[new_projectile_path_index]
			var new_projectile = new_projectile_packed_scene.instantiate()
			add_child(new_projectile)
			new_projectile.global_position = enemy_global_position
			new_projectile.speed = 250
			var shotgun_spread = 0.12 * (n - 1)
			var direction_modifier = 1 - shotgun_spread
			new_projectile.target = get_player_position() * direction_modifier
			new_projectile.direction = (new_projectile.target - enemy_global_position).normalized() 



func load_projectiles(projectile_paths: Array[String]):
	if projectile_paths.size() == 0:
		print("ERROR: NO PROJECTILE PATHS SET IN PROJECTILE MANAGER!")
		return
	for projectiles in projectile_paths.size():
		var this_projectile_path: String = projectile_paths[projectiles - 1]
		if not FileAccess.file_exists(this_projectile_path):
			print("ERROR: PROJECTILE DOES NOT EXIST:   ", this_projectile_path)
		else:
			projectile_packed_scenes.append(load(this_projectile_path))
			print("Succesfully loaded projectile:   ", this_projectile_path)
