extends Sprite2D

var original_rotation: float
@onready var animation_player = $AnimationPlayer

func _ready():
	original_rotation = rotation
	animation_player.current_animation = "rod_attack"
