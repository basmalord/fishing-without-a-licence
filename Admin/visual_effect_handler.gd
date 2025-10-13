extends Node

class_name VisualEffectHandler

@onready var player: Player = get_parent()

func flash_red():
	player.player_animation_sprite.modulate = Color(1, 0, 0, 0.5)
	await get_tree().create_timer(0.1).timeout
	player.player_animation_sprite.modulate = Color(1, 1, 1, 1)
