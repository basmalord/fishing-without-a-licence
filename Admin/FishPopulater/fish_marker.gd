extends AnimatedSprite2D

@onready var fish_populater: FishPopulator = get_parent()
@onready var fishing_area = $FishingArea
@onready var marker_timer = $MarkerTimer
@onready var cast_timer = $CastTimer
@onready var audio_streamer = $MarkerAudioStreamer

@export var cast_ticks_median: int

var original_time 
var ready_check = false
var player_has_cast = false
var cast_ticks: int
var release_tick: int
var catch_fish_sprite_scene_path: String = "res://Fishing/catch_sprite.tscn"
var timer_bug_check: bool = false


func _ready():
	marker_timer.wait_time = randi_range(marker_timer.wait_time - 2, marker_timer.wait_time + 2)
	original_time = marker_timer.wait_time
	marker_timer.start()
	ready_check = true
	frame = randi_range(0, sprite_frames.get_frame_count("FishMarker"))
	play()

func _process(float): #must fix the added ticks post-queue_free
	if cast_ticks != null:
		if cast_ticks < 0:
			remove_marker()
	if ready_check == true:
		if player_has_cast == false:
			var marker_timer_time_left = marker_timer.time_left
			var animiation_speed_multiplier = clamp(original_time / marker_timer_time_left, 0, 3)
			speed_scale = animiation_speed_multiplier
			if marker_timer_time_left < 1:
				animation = "Splash"
		else:
			pass



func player_cast_behaviour_setup():
	print("Running player_cast_behaviour_setup")
	marker_timer.stop()
	stop()
	animation = "FishMarker"
	frame = 0
	speed_scale = 1.86
	cast_ticks = randi_range(cast_ticks_median * 0.75, cast_ticks_median * 1.25)
	cast_ticks = round(cast_ticks)
	release_tick = randf_range(0, cast_ticks - 2)
	cast_timer.start()
	player_has_cast = true
	play()
	print("realse tick: ", release_tick)

func on_cast_tick():
	if Input.is_action_pressed("FISH"):
		print(self, cast_ticks, global_position)
		cast_ticks -= 1
		if cast_ticks == release_tick:
			if Input.is_action_pressed("FISH"):
				audio_streamer.play_caught_fish_sound()
		elif cast_ticks >= 0:
			audio_streamer.play()
		if cast_ticks == 0:
			print("You're all out of TIME")

func remove_marker():
	fish_populater.exclude_cell(self)
	fish_populater.update_fish_markers()
	queue_free()

func reel_check():
	if release_tick == cast_ticks or release_tick == cast_ticks -1:
		print("You hit it!")
		cast_timer.stop()
		animation = "Splash"
		audio_streamer.play_splash_sound()
		var caught_fish_packed_scene = load(catch_fish_sprite_scene_path)
		var caught_fish = caught_fish_packed_scene.instantiate()
		add_child(caught_fish)
		fishing_area.player.fish_counter.add_fish(caught_fish.active_fish, 1)
		caught_fish.position = position
		fishing_area.player.is_inside_fishing_area = false
		fishing_area.player.current_fishing_area = null
	else:
		print("You Missed!")
		remove_marker()

func hot_fix_for_timer_bug():
	timer_bug_check = true
	await get_tree().create_timer(cast_timer.wait_time - 0.005, false).timeout
	timer_bug_check = false
