extends Area2D

@export_enum("Left","Right","Up","Down") var direction_of_water: String
@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var my_box = get_children()[0]


func _on_player_entered(body: Node2D) -> void:
	if body is not Player:
		return
	player.is_inside_fishing_area = true
	player.set_water_direction(direction_of_water, self)
	print(direction_of_water)




func _on_player_exited(body: Node2D) -> void:
	if body is not Player:
		return
	player.is_inside_fishing_area = false


func reel():
	var fish_marker_animation = get_parent()
	fish_marker_animation.reel_check()

func cast():
	var fish_marker_animation = get_parent()
	fish_marker_animation.player_cast_behaviour_setup()
