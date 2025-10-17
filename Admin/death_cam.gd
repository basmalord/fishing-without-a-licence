extends Node2D

@onready var animation_player = $DeathSprite/AnimationPlayer
@onready var death_sprite = $DeathSprite
@onready var audio_streamer = $AudioStreamPlayer

func _ready():
	animation_player.current_animation = "death_animation"
	animation_player.play()
	audio_streamer.play()
	print("DC GP AND P: ",global_position, " ",position, z_index, z_as_relative)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_parent().end_screen()
