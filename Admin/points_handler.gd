extends Control

class_name PointsHandler


@onready var points_label = $PointsLabel

var points: int = 0

func _ready():
	update_points(points)

func add_points(additional_points: int = 1):
	points += additional_points
	update_points(points)

func update_points(updated_points: int):
	var points_text = "Points: " + str(updated_points)
	points_label.text = points_text
