extends Effect

func _ready():
	super._ready()




func effect(player: Player):
	if player.hearts.size() < 5:
		player.receive_health()
		get_parent().queue_free()
