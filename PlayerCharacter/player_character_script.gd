extends CharacterBody2D

class_name Player

@onready var player_animation_sprite = $PlayerAnimatedSprite
@onready var player_box = $PlayerBox

@export var speed: int
@export var sprint_modifier: int

func _physics_process(delta: float) -> void:
	player_move()
	select_animation()


func _input(event: InputEvent) -> void:
	pass

func _process(delta: float) -> void:
	pass

func player_move():
	var input_direction = Input.get_vector("MOVE_LEFT","MOVE_RIGHT","MOVE_UP","MOVE_DOWN")
	var move_speed: int 
	if Input.is_action_pressed("SPRINT"):
		move_speed = speed + sprint_modifier
	else:
		move_speed = speed
	velocity = input_direction * move_speed
	move_and_slide()

func select_animation():
	var animation_velocity: Vector2 = velocity
	if animation_velocity == Vector2(0,0):
		player_animation_sprite.flip_h = false
		player_animation_sprite.animation = "Idle"
	elif animation_velocity.x == -speed or animation_velocity.x == speed or animation_velocity.x == -speed - sprint_modifier or animation_velocity.x == speed + sprint_modifier:
		player_animation_sprite.animation = "MoveSideways"
		if velocity.x < 0:
			player_animation_sprite.flip_h = false
		else:
			player_animation_sprite.flip_h = true
	elif animation_velocity.y > 0:
		player_animation_sprite.flip_h = false
		player_animation_sprite.animation = "MoveTowardCamera"
	else:
		player_animation_sprite.flip_h = false
		player_animation_sprite.animation = "MoveAwayFromCamera"

func kill():
	print("player is dead")
	set_process(false)
	set_physics_process(false)
