extends Effect

class_name Damage


@export var damage: int 

func effect(player: Player):
	if damage != null:
		player.receive_damage(damage)
	queue_free()
