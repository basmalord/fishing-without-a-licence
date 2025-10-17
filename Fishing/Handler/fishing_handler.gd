extends Node

class_name FishingHandler

@onready var player: Player = get_parent() #defines reference to player at startup, will not work if it is not a direct child of parent

func point_player(direction_name: String):
	match direction_name:
		"Left":
			if player.player_animation_sprite.flip_h == true:
				player.player_animation_sprite.flip_h = false
			player.player_animation_sprite.animation = "FishingSideways"
			#if player.player_animation_sprite.frame == 9: 
				#player.points_handler.add_points()
				#player.player_animation_sprite.frame = 5
		"Right":
			player.player_animation_sprite.animation = "FishingSideways"
			player.player_animation_sprite.flip_h = true
			#if player.player_animation_sprite.frame == 9: 
				#player.points_handler.add_points() #points added here on sideways fishing because the animation doesn't fully loop, best to change animation rather than code
				#player.player_animation_sprite.frame = 5
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
		if player.player_animation_sprite.animation == "FishingDown":
			player.player_animation_sprite.animation = "FishingDownIdle"
		elif player.player_animation_sprite.animation == "FishingUp":
			player.player_animation_sprite.animation = "FishingUpIdle"
		elif player.player_animation_sprite.animation == "FishingSideways":
			player.player_animation_sprite.animation = "FishingSidewaysIdle"
