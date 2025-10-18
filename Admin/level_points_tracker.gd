extends Node

@onready var audio_streamer = $AudioStreamPlayer
@onready var player = get_tree().get_first_node_in_group("Player")


@export var level_points: int

var player_points: int = 0

func update_level_points(points: int):
	player_points = points
	print(player_points, level_points)
	if player_points >= level_points:
		await get_tree().create_timer(1).timeout
		player.is_invincible = true
		player.get_parent().set_enemies_to_idle()
		audio_streamer.play()
		await get_tree().create_timer(4).timeout
		change_level()

func change_level():
	get_tree().get_first_node_in_group("LevelManager").change_level()
