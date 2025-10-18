extends Node

class_name CombatAiManager

@onready var projectile_timer: Timer = $ProjectileTimer
@onready var my_enemy = get_parent()
var signal_connected: bool = false

var my_enemy_name: String

func _ready():
	my_enemy_name = my_enemy.npc_name
	set_timer()
	print(self, projectile_timer)

func _process(delta: float) -> void:
	engage_combat_strategy()

func engage_combat_strategy():
	match my_enemy_name:
		"No Weapons Police":
			return
		"Pistol Police":
			if my_enemy.state_machine.state == "Alert":
				if !signal_connected:
					connect_timer_ended_signal_to_projectile()
					signal_connected = true
			else:
				signal_connected = false
				disconnect_timer_ended_signal()
		"Shotgun Police":
			if my_enemy.state_machine.state == "Alert":
				if !signal_connected:
					connect_timer_ended_signal_to_projectile()
					signal_connected = true
			else:
				signal_connected = false
				disconnect_timer_ended_signal()

func set_timer():
	match my_enemy_name:
		"No Weapons Police":
			projectile_timer.stop()
		"Pistol Police":
			projectile_timer.wait_time = 1.5
		"Shotgun Police":
			projectile_timer.wait_time = 3

func connect_timer_ended_signal_to_projectile():
	print("signal connected")
	projectile_timer.connect("timeout", Callable(my_enemy, "instantiate_projectile"))

func disconnect_timer_ended_signal():
	if projectile_timer.is_connected("timeout", Callable(my_enemy, "instantiate_projectile")):
		projectile_timer.disconnect("timeout", Callable(my_enemy, "instantiate_projectile"))
