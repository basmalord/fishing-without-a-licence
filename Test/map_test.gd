extends Node2D

func set_enemies_to_idle():
	for child in get_children():
		if child is Enemy:
			for grandchild in child.get_children():
				if grandchild is EnemyAlertArea:
					grandchild.set_process(false)
					grandchild.set_physics_process(false)
			child.state_machine.state = "Idle"


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
