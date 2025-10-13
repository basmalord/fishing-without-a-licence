extends Node

class_name EnemyStateMachine

@onready var my_enemy: Enemy = get_parent()

var state: String = "Idle"

var states: Array[String] = ["Idle","Alert"]

func _physics_process(delta: float) -> void:
	match state:
		"Idle":
			my_enemy.npc_animation_sprite.animation = "Idle"
			my_enemy.target_position = my_enemy.global_position
		"Alert":
			my_enemy.npc_animation_sprite.animation = "MoveTowardCamera"
			my_enemy.follow_player()


func set_state(new_state: String):
	if states.find(new_state) == -1:
		print("ERROR IN STATE MACHINE: NOT LISTED STATE!")
		return
	print("SEtting state")
	state = new_state
