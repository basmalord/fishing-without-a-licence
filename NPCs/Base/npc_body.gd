extends CharacterBody2D

class_name NPC

var npc_animation_sprite: AnimatedSprite2D
var npc_box: CollisionShape2D
var projectile_manager: ProjectileManager

@export var speed: int
@export var sprite_frames: SpriteFrames
@export var npc_name: String
@export_enum("Enemy", "Non-enemy") var npc_type: String
 
var target_position: Vector2 = position

func _ready():
	initialise_collision_box_and_animated_sprite()
	set_collision_box_shape()
	set_sprite_frames_and_play()

func _physics_process(delta: float) -> void:
	npc_move()
	move_and_slide()

func set_projectile_manager():
	if get_tree().get_first_node_in_group("ProjectileManager") != null:
		projectile_manager = get_tree().get_first_node_in_group("ProjectileManager")

func get_player_position():
	var player
	var player_position
	if get_parent() == null:
		print("This Enemy, ", self, "has no parent.")
		return
	else:
		if get_tree().get_first_node_in_group("Player") != null:
			player = get_tree().get_first_node_in_group("Player")
			player_position = player.position
	return player_position

func npc_move():
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed

func initialise_collision_box_and_animated_sprite():
	var new_anim_sprite = AnimatedSprite2D.new()
	add_child(new_anim_sprite)
	npc_animation_sprite = new_anim_sprite
	var new_collision_box = CollisionShape2D.new()
	add_child(new_collision_box)
	npc_box = new_collision_box

func set_sprite_frames_and_play():
	npc_animation_sprite.sprite_frames = sprite_frames
	npc_animation_sprite.play()

func set_collision_box_shape():
	var new_shape = CapsuleShape2D.new()
	npc_box.shape = new_shape
