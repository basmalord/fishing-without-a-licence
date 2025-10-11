extends Area2D

@export_enum("Left","Right","Up","Down") var direction_of_water: String


func _on_player_entered(body: Node2D) -> void:
	if body is not Player:
		pass
	var player = body
	player.is_inside_fishing_area = true
	player.set_water_direction(direction_of_water)


func _on_player_exited(body: Node2D) -> void:
	if body is not Player:
		pass
	var player = body
	player.is_inside_fishing_area = false
