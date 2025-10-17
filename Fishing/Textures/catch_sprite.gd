extends Sprite2D

class_name CatchSprite

@onready var animation_player = $AnimationPlayer



@export var fish: Dictionary[String, String]
var active_fish: String


func _ready():
	load_fish_sprites(fish)
	set_active_fish()
	set_texture_to_active_fish()
	orientate()


func load_fish_sprites(fish_sprite_dict: Dictionary[String, String]):
	if fish_sprite_dict.keys().size() == 0:
		print("ERROR: NO FISH TO LOAD IN CATCH SPRITE NODE")
		return
	for fish in fish_sprite_dict.keys():
		var fish_sprite_path = fish_sprite_dict[fish]
		load(fish_sprite_path)

func set_random_active_fish():
	if fish.keys().size() == 0:
		return
	var fish_names = fish.keys()
	var randomly_selected_fish_index = randi_range(1, fish.keys().size()) - 1
	active_fish = fish.keys()[randomly_selected_fish_index]
	print(active_fish)

func set_active_fish():
	if fish.keys().size() == 0:
		return
	var random_number = randi_range(1,10)
	var random_flip = randi_range(1,2)
	match random_number:
		10:
			active_fish = "Gold Fish"
		9, 8:
			if random_flip == 1:
				active_fish = "Blue Fish"
			else:
				active_fish = "Red Fish"
		7,6,5:
			if random_flip == 1:
				active_fish = "Purple Fish"
			else:
				active_fish = "Angled Red Fish"
		4,3,2,1:
			if random_flip ==1:
				active_fish = "Teal Fish"
			else:
				active_fish = "Orange Fish"

func set_texture_to_active_fish():
	var active_fish_path = fish[active_fish]
	texture = load(active_fish_path)
	scale = scale * 0.35
	animation_player.current_animation = "FishCaught"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if get_parent() != null:
		print(get_parent())
		get_parent().queue_free()

func orientate():
	if get_parent() == null:
		return
	if get_parent().rotation != 0:
		rotation = -1.570796
		animation_player.current_animation = "FishCaughtYAdjusted"
