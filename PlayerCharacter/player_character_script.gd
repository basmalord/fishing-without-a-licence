extends CharacterBody2D

class_name Player

@onready var player_animation_sprite = $PlayerAnimatedSprite
@onready var player_box = $PlayerBox
@onready var fishing_handler = $FishingHandler
@onready var points_handler = $PointsHandler
@onready var visual_effect_handler = $VisualEffectHandler
@onready var fish_counter = $FishCounter
@onready var hit_sound = $HitSound
@onready var hearts: Array[Sprite2D] = [$Heart1, $Heart2, $Heart3, $Heart4, $Heart5]

#@onready var attack_rod = $AttackRod


@export var speed: int
@export var sprint_modifier: int

@export_enum("Yellow","Red","Purple","Default") var fishing_rod_type: String

var is_inside_fishing_area: bool = false
var is_fishing: bool = false
var player_direction_of_water: String 
var fishing_rod_collection: Array[String] = ["Default", "Red", "Yellow", "Purple"]
var current_fishing_area: Node2D
var is_dead = false
var last_heart_position
var attack_rod_original_position: Vector2
var is_attacking: bool = false
var is_invincible: bool = false
const DeathScene = preload("res://Admin/death_cam.tscn")

func _ready():
	pass
	#attack_rod_original_position = attack_rod.global_position
	#attack_rod.global_position.y = attack_rod_original_position.y - 50
	#attack_rod.hide()
	#attack_rod.set_process(false)
	#attack_rod.set_physics_process(false)


func _physics_process(delta: float) -> void:
	if !is_dead:
		if !is_invincible:
			fishing_input()
			if is_fishing == false:
				player_move()
				select_animation()
				move_and_slide()
				#if Input.is_action_just_pressed("ROD SLOT 1"):
					#if !is_attacking:
						#attack_rod.set_process(true)
						#attack_rod.set_physics_process(true)
						#attack_rod.show()
						#attack_rod.animation_player.play()
						#set_is_attacking()
				if Input.is_action_just_pressed("SHOW FISH"):
					print(fish_counter.fish)

func set_is_attacking():
	pass
	#is_attacking = true
	#await get_tree().create_timer(0.4).timeout #has to be roughly the same amount of time as the animation
	#attack_rod.hide()
	#attack_rod.set_process(false)
	#attack_rod.set_physics_process(false)
	#is_attacking = false

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


func select_animation():
	var animation_velocity: Vector2 = velocity
	if animation_velocity == Vector2(0,0):
		player_animation_sprite.flip_h = false
		player_animation_sprite.animation = "Default"
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
		if is_inside_fishing_area:
			if is_instance_valid(current_fishing_area) == false:
				return
			current_fishing_area.reel()
	if Input.is_action_pressed("FISH"):
		if is_inside_fishing_area:
			if player_direction_of_water != null:
				if player_animation_sprite.animation.find("Idle") == -1:
					is_fishing = true
					velocity = Vector2(0,0)
					fishing_handler.point_player(player_direction_of_water)

func set_water_direction(direction_of_water: String, fishing_area: Node2D):
	current_fishing_area = fishing_area
	player_direction_of_water = direction_of_water
	if is_instance_valid(current_fishing_area):
		current_fishing_area.cast()
		print("casting")

func receive_damage(damage: int):
	if !is_dead:
		if !is_invincible:
			hit_sound.play()
			visual_effect_handler.flash_red()
			if get_tree().get_nodes_in_group("hearts").size() == 1:
				var heart_to_destroy = hearts[0]
				last_heart_position = heart_to_destroy.position
				hearts.erase(heart_to_destroy)
				heart_to_destroy.queue_free()
				player_animation_sprite.hide()
				player_box.hide()
				var my_death_scene = DeathScene.instantiate()
				add_child(my_death_scene)
				is_dead = true
				get_parent().set_enemies_to_idle()
				return
			var heart_to_destroy = hearts[0]
			last_heart_position = heart_to_destroy.position
			hearts.erase(heart_to_destroy)
			heart_to_destroy.queue_free()

func end_screen():
	var end_screen = "res://UI/Start Screen/death_screen.tscn"
	get_tree().change_scene_to_file(end_screen)

func add_rod(rod_type: String):
	fishing_rod_collection.append(rod_type)

func receive_health():
	if get_tree().get_nodes_in_group("hearts").size() < 5:
		print("before: ", get_tree().get_nodes_in_group("hearts"))
		var heart = get_tree().get_first_node_in_group("hearts")
		var new_heart = heart.duplicate()
		add_child(new_heart)
		new_heart.position = last_heart_position
		hearts.insert(0, new_heart)
		print("after: ",get_tree().get_nodes_in_group("hearts").size())

#func rod_select():
	#if Input.is_action_just_pressed("ROD SLOT 1"):
		#fishing_rod_type = "Default"
		#match fishing_rod_type:
			#"Red":
				#ui_rod.modulate = Color(1, 0, 0, 1)
			#"Yellow":
				#ui_rod.modulate = Color(1, 1, 0, 1)
			#"Purple":
				#ui_rod.modulate = Color(0.5, 0, 0.5, 1)
			#"Default":
				#ui_rod.modulate = Color(1, 1, 1, 1)
	#if Input.is_action_just_pressed("ROD SLOT 2"):
		#if fishing_rod_collection.size() < 2:
			#return
		#fishing_rod_type = fishing_rod_collection[1]
		#match fishing_rod_type:
			#"Red":
				#ui_rod.modulate = Color(1, 0, 0, 1)
			#"Yellow":
				#ui_rod.modulate = Color(1, 1, 0, 1)
			#"Purple":
				#ui_rod.modulate = Color(0.5, 0, 0.5, 1)
			#"Default":
				#ui_rod.modulate = Color(1, 1, 1, 1)
	#if Input.is_action_just_pressed("ROD SLOT 3"):
		#if fishing_rod_collection.size() < 3:
			#return
		#fishing_rod_type = fishing_rod_collection[2]
		#match fishing_rod_type:
			#"Red":
				#ui_rod.modulate = Color(1, 0, 0, 1)
			#"Yellow":
				#ui_rod.modulate = Color(1, 1, 0, 1)
			#"Purple":
				#ui_rod.modulate = Color(0.5, 0, 0.5, 1)
			#"Default":
				#ui_rod.modulate = Color(1, 1, 1, 1)
	#if Input.is_action_just_pressed("ROD SLOT 4"):
		#if fishing_rod_collection.size() < 4:
			#return
		#fishing_rod_type = fishing_rod_collection[3]
		#match fishing_rod_type:
			#"Red":
				#ui_rod.modulate = Color(1, 0, 0, 1)
			#"Yellow":
				#ui_rod.modulate = Color(1, 1, 0, 1)
			#"Purple":
				#ui_rod.modulate = Color(0.5, 0, 0.5, 1)
			#"Default":
				#ui_rod.modulate = Color(1, 1, 1, 1)
