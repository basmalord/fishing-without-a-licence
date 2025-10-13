extends NPC

class_name Enemy

@onready var state_machine = $EnemyStateMachine



var attack_generator: AttackGenerator

@export_enum("Kill") var attack_type: String
@export_enum("Damage Bullet") var projectile_type: String
@export var attack_size: Vector2



func _ready():
	super._ready()
	instantiate_attack_generator()
	call_attack_generator_generate_attack()



func _physics_process(delta: float) -> void:
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

func instantiate_projectile():
	var projectile_manager_new = get_tree().get_first_node_in_group("ProjectileManager")
	if npc_name != "Shotgun Police":
		projectile_manager_new.instantiate_projectile("res://Projectiles/Damage/Bullet/damage_bullet.tscn", self.global_position)
	else:
		projectile_manager_new.instantiate_projectile("res://Projectiles/Damage/Bullet/damage_bullet.tscn", self.global_position, true)

func instantiate_attack_generator():
	var new_attack_generator = AttackGenerator.new()
	add_child(new_attack_generator)
	attack_generator = new_attack_generator

func call_attack_generator_generate_attack():
	attack_generator.generate_attack(attack_type, self, attack_size)
