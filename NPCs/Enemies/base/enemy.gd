extends NPC

class_name Enemy

var attack_generator: AttackGenerator

@export_enum("Kill","Projectile") var attack_type: String
@export var attack_size: Vector2

func _ready():
	super._ready()
	instantiate_attack_generator()
	call_attack_generator_generate_attack()


func _physics_process(delta: float) -> void:
	follow_player()
	super._physics_process(delta)


func follow_player():
	if target_position != null:
		target_position = get_player_position()

func kill_player(player: Player):
	if player == null:
		print("no player detected")
		pass
	else:
		player.kill()

func instantiate_attack_generator():
	var new_attack_generator = AttackGenerator.new()
	add_child(new_attack_generator)
	attack_generator = new_attack_generator

func call_attack_generator_generate_attack():
	attack_generator.generate_attack(attack_type, self, attack_size)
