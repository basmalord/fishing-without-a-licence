extends CharacterBody2D

class_name Player

@onready var player_animation_sprite = $PlayerAnimatedSprite
@onready var player_box = $PlayerBox
@onready var fishing_handler = $FishingHandler


@export var speed: int
@export var sprint_modifier: int

var is_inside_fishing_area: bool = false
var is_fishing: bool = false
var player_direction_of_water: String 


func _physics_process(delta: float) -> void:
	fishing_input()
	if is_fishing == false:
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

func fishing_input():
	if Input.is_action_just_released("FISH"):
		is_fishing = false
	if Input.is_action_pressed("FISH"):
		if is_inside_fishing_area:
			if player_direction_of_water != null:
				is_fishing = true
				velocity = Vector2(0,0)
				fishing_handler.point_player(player_direction_of_water)


func set_water_direction(direction_of_water):
	player_direction_of_water = direction_of_water
