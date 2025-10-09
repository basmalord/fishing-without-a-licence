extends Area2D

class_name Effect

func _ready():
	generate_collision_box()
	connect_body_entered_signal()

func _on_player_entered(body: Node2D) -> void:
	if body is not Player:
		print("Non-player body enetered")
		pass
	else:
		effect(body)

func effect(player: Player):
	pass

func generate_collision_box():
	var new_box = CollisionShape2D.new()
	var new_shape = CircleShape2D.new()
	add_child(new_box)
	new_box.shape = new_shape

func connect_body_entered_signal():
	connect("body_entered", Callable(self, "_on_player_entered"))
