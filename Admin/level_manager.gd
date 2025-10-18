extends Node

@export var levels: Dictionary[String, String]
@export var player_start_position: Vector2


var active_level: String
var active_level_path: String
var level_dictionary_key: Array[String] = ["LevelOne", "LevelTwo", "LevelThree", "LevelFour", "LevelFive", "WinScreen"]


func _ready():
	if levels.size() != 0:
		active_level_path = get_tree().current_scene.scene_file_path
		active_level = levels.find_key(active_level_path)
		print("This is: ", active_level)

func change_level():
	var active_level_index: int =  level_dictionary_key.find(active_level)
	var next_level_index = active_level_index + 1
	var next_level_name = level_dictionary_key[next_level_index]
	var next_level_path = levels[next_level_name]
	get_tree().change_scene_to_file(next_level_path)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ROD SLOT 2"):
		change_level()
