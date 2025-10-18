extends Control

func _on_yes_pushed():
	get_tree().change_scene_to_file("res://Level_SmallMap/Level_1_SmallMap.tscn")

func _on_no_pushed():
	get_tree().quit()
