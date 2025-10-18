extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Level_SmallMap/Level_1_SmallMap.tscn")
