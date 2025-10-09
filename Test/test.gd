extends Node2D



func _on_button_pressed() -> void:
	for n in get_children().size():
		if get_children()[n] is not Sprite2D:
			get_children()[n].scale *= 0.5
