extends Node

class_name FishCounter

var fish: Dictionary = {"Red Fish": 0, "Blue Fish": 0, "Purple Fish": 0, "Gold Fish": 0, "Angled Red Fish": 0, "Teal Fish": 0, "Orange Fish": 0,}

@onready var player = get_parent()


func add_fish(fish_type: String, amount: int):
	fish[fish_type] += amount
	player.points_handler.add_points(fish_type, amount)


func subtract_fish(fish_type: String, amount: int):
	fish[fish_type] -= amount
	player.points_handler.subtract_points(fish_type, amount)
