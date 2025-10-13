extends NPC
class_name Merchant

@onready var merchant_area = $MerchantArea
@onready var rod_sprite = $MerchantRodSprite

@export_enum("Red", "Yellow", "Purple", "Sold") var rod_type: String

@export var cost: Dictionary = {"Red Fish": 0, "Blue Fish": 0, "Purple Fish": 0, "Gold Fish": 0}

var player_check: bool = false

var player: Player

func _ready():
	super._ready()
	set_animation()
	connect_merchant_area()

func _process(delta: float) -> void:
	if player_check == true:
		if rod_type != "Sold":
			if Input.is_action_just_pressed("FISH"):
				var player_fish = player.fish_counter.fish
				var temp_cost = cost
				var keys = player_fish.keys()
				var matches: int = 0
				for n in 4:
					var fish_to_check = temp_cost[keys[n]]
					if fish_to_check <= player_fish[keys[n]]:
						matches += 1
				if matches == 4:
					player.add_rod(rod_type)
					player_check = false
					rod_type = "Sold"
				else:
					print("Don't have the Required Fish")

func set_animation():
	match rod_type:
		"Red":
			npc_animation_sprite.animation = "Red Merchant"
		"Yellow":
			npc_animation_sprite.animation = "Yellow Merchant"
		"Purple":
			npc_animation_sprite.animation = "Purple Merchant"
		"Sold":
			rod_sprite.modulate = Color(0, 1, 0, 0.5)

func _on_player_entered(body: Node2D):
	if body is not Player:
		print("not player")
		return
	player = body
	player_check = true


func connect_merchant_area():
	merchant_area.connect("body_entered", Callable(self, "_on_player_entered"))
