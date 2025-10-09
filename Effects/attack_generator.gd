extends Node
class_name AttackGenerator

func generate_attack(attack_type: String, enemy: Enemy, size_of_attack: Vector2 = Vector2(2,2)):
	var new_effect
	if size_of_attack.x < 2:
		size_of_attack = Vector2(2,2)
	match attack_type:
		"Kill":
			new_effect = KillEffect.new()
			enemy.add_child(new_effect)
			new_effect.scale.x = size_of_attack.x
			new_effect.scale.y = size_of_attack.y
