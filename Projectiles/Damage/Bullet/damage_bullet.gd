extends Damage

@onready var my_manager: ProjectileManager = get_parent()

@export var speed: float

var target: Vector2
var direction: Vector2
var new_global_position: Vector2

func _ready():
	super._ready()
	set_physics_process(false)
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
