extends Area2D


func _on_projectile_entered(area: Area2D) -> void:
	if area is Damage:
		print("I've been hit!")
