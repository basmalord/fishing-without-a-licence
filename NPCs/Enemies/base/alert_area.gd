extends Area2D

class_name EnemyAlertArea

@onready var enemy_alert_area_box: CollisionShape2D = $EnemyAlertBox
@onready var my_enemy = get_parent()


@export var enemy_alert_area_size: float


func _on_player_entered(body: Node2D):
	if body is not Player:
		return
	if body is Player:
		print("worked")
		my_enemy.state_machine.set_state("Alert")


func _on_player_exited(body: Node2D):
	if body is not Player:
		return
	my_enemy.state_machine.set_state("Idle")

func _ready():
	enemy_alert_area_box.scale.x = enemy_alert_area_size
	enemy_alert_area_box.scale.y = enemy_alert_area_size
	connect_body_entered_signal()
	connect_body_exited_signal()


func connect_body_entered_signal():
	connect("body_entered", Callable(self, "_on_player_entered"))

func connect_body_exited_signal():
	connect("body_exited", Callable(self, "_on_player_exited"))
