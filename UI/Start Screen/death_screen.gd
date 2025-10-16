extends Control

func _on_yes_pushed():
	var new_game = preload("res://Test/map_test.tscn")
	get_tree().change_scene_to_file("res://Test/map_test.tscn")

func _on_no_pushed():
	get_tree().quit()
