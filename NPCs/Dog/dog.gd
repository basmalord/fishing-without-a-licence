extends NPC

func _ready():
	super._ready()
	scale = scale * 0.5

func npc_move():
	direction = Vector2(0,0)
	velocity = speed * direction

func dog_set_target_global_position():
	pass
	#direction = direction * randf_range(-1.0, 1.0)
	#print("DOG MOVING", velocity, direction)
	#print("DOG MOVING")
	#var possible_moves: Array[Vector2]
	#var map = get_tree().get_first_node_in_group("Map")
	#var tile_map_positions = map.get_used_cells()
	#for cell in tile_map_positions:
		#var cell_data = map.get_cell_tile_data(cell)
		#if cell_data.has_custom_data("fishing_direction"):
			#var fishing_direction = cell_data.get_custom_data("fishing_direction")
			#if fishing_direction == "":
				#possible_moves.append(cell)
				#print(cell)
	#var target_cell = tile_map_positions[randi_range(0, possible_moves.size())]
	#var local_cell_position = map.map_to_local(target_cell)
	#var global_cell_position = map.to_global(local_cell_position)
	#target_position = global_cell_position
	#print(target_position)
