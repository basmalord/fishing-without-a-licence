extends Node

class_name FishingHandler

@onready var player: Player = get_parent() #defines reference to player at startup, will not work if it is not a direct child of parent

func point_player(direction_name: String):
	match direction_name:
		"Left":
			if player.player_animation_sprite.flip_h == true:
				player.player_animation_sprite.flip_h = false
			player.player_animation_sprite.animation = "FishingSideways"
			if player.player_animation_sprite.frame == 8: 
				player.points_handler.add_points()
				player.player_animation_sprite.frame = 4
		"Right":
			player.player_animation_sprite.animation = "FishingSideways"
			player.player_animation_sprite.flip_h = true
			if player.player_animation_sprite.frame == 8: 
				player.points_handler.add_points() #points added here on sideways fishing because the animation doesn't fully loop, best to change animation rather than code
				player.player_animation_sprite.frame = 4
			player.fishing_rod.flip_h = true
			player.fishing_rod.position = player.fishing_rod.flipped_position 
		"Up":
			if player.player_animation_sprite.flip_h == true:
				player.player_animation_sprite.flip_h = false
			player.player_animation_sprite.animation = "FishingUp"
		"Down":
			if player.player_animation_sprite.flip_h == true:
				player.player_animation_sprite.flip_h = false
			player.player_animation_sprite.animation = "FishingDown"



func _on_fishing_animation_looped() -> void:
	if player.player_animation_sprite.animation.find("Fishing") != -1:
		player.points_handler.add_points()
		var fish_type: String
		var rod_type = player.fishing_rod_type
		match rod_type:
			"Default":
				fish_type = "Blue Fish"
			"Red":
				fish_type = "Red Fish"
			"Purple":
				fish_type = "Purple Fish"
			"Yellow":
				fish_type = "Yellow Fish"
		player.fish_counter.add_fish(fish_type, 1)
