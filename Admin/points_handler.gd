extends Control

class_name PointsHandler


@onready var points_label = $PointsLabel

var points: int = 0

func _ready():
	update_points(points)

func add_points(point_type: String, amount: int = 1):
	match point_type:
		"Teal Fish":
			points += 1 * amount
		"Orange Fish":
			points += 1 * amount
		"Blue Fish":
			points += 3 * amount
		"Red Fish":
			points += 3 * amount
		"Purple Fish":
			points += 2 * amount
		"Angled Red Fish":
			points += 2 * amount
		"Gold Fish":
			points += 4 * amount
	update_points(points)

func subtract_points(point_type: String, amount: int = 1):
	match point_type:
		"Teal Fish":
			points -= 1 * amount
		"Orange Fish":
			points -= 1 * amount
		"Blue Fish":
			points -= 3 * amount
		"Red Fish":
			points -= 3 * amount
		"Purple Fish":
			points -= 2 * amount
		"Angled Red Fish":
			points -= 2 * amount
		"Gold Fish":
			points -= 4 * amount
	update_points(points)

func update_points(updated_points: int):
	var points_text = "Points: " + str(updated_points)
	points_label.text = points_text
