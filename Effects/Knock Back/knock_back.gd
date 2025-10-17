extends Effect

func _on_player_entered(body: Node2D) -> void: 
	if body is not Enemy:
		return


func effect(enemy: Node2D):
	pass
