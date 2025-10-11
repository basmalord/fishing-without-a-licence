extends Node

class_name FishingHandler

@onready var player: Player = get_parent() #defines reference to player at startup, will not work if it is not a direct child of parent

func point_player(direction_name: String):
	match direction_name:
		"Left":
			if player.player_animation_sprite.flip_h == true:
				player.player_animation_sprite.flip_h = false
			player.player_animation_sprite.animation = "FishingSideways"
			if player.player_animation_sprite.frame == 8: #and player.player_animation_sprite.frame_progress == 0.7:
				player.player_animation_sprite.frame = 4
		"Right":
			player.player_animation_sprite.animation = "FishingSideways"
			player.player_animation_sprite.flip_h = true
			if player.player_animation_sprite.frame == 8: #and player.player_animation_sprite.frame_progress >= 0.7:
				player.player_animation_sprite.frame = 4
		"Up":
			if player.player_animation_sprite.flip_h == true:
				player.player_animation_sprite.flip_h = false
			player.player_animation_sprite.animation = "FishingUp"
		"Down":
			if player.player_animation_sprite.flip_h == true:
				player.player_animation_sprite.flip_h = false
			player.player_animation_sprite.pause()
			player.player_animation_sprite.animation = "MoveTowardCamera"
			player.player_animation_sprite.frame = 0
