extends AudioStreamPlayer2D

@onready var marker = get_parent()
@onready var audio_timer = $MarkerAudioTimer


var caught_fish_sound_location: String = "res://Fishing/Sounds/caught_fish_sound.wav"

var caught_fish_sound: AudioStream = null

func _ready():
	caught_fish_sound = load(caught_fish_sound_location)

func play_caught_fish_sound():
	if caught_fish_sound:
		stream = caught_fish_sound
		play()
	else:
		print("ERRRO: CAUGHT FISH SOUND NOT LOADED")
