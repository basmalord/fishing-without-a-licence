extends Sprite2D

var original_position: Vector2
var flipped_position: Vector2
var forward_fishing_position: Vector2

func _ready():
	original_position = position
	flipped_position = position
	flipped_position.x = flipped_position.x + 117
	forward_fishing_position.x = original_position.x + 35
	forward_fishing_position.y = original_position.y - 10
	print("fishing rod here, ", original_position, flipped_position)
