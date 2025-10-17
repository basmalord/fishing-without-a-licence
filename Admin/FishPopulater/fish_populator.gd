extends Node

class_name FishPopulator

@onready var map: TileMapLayer = get_tree().get_first_node_in_group("Map")
@export var max_fish_markers: int = 10


const fish_marker = preload("res://Admin/FishPopulater/fish_marker.tscn")

var fishable_tiles: Dictionary [Vector2i, String]
var fishable_tiles_position_data: Array[Vector2i]
var tiles_with_markers: Array[Vector2i] = []
var ready_check = false
var excluded_cells: Array
func _ready():
	var tile_map_positions = map.get_used_cells()
	for cell in tile_map_positions:
		var cell_data = map.get_cell_tile_data(cell)
		if cell_data.has_custom_data("fishing_direction"):
			var direction = cell_data.get_custom_data("fishing_direction")
			if direction != "":
				fishable_tiles[cell] = direction
				fishable_tiles_position_data.append(cell)
	ready_check = true


func _process(delta: float) -> void:
	if ready_check == true:
		load_fish_markers()
		update_fish_markers()



func update_fish_markers():
	for cell in tiles_with_markers:
		var marker_death_check: bool = false
		for child in get_children():
			if tiles_with_markers.find(child.global_position) == -1:
				marker_death_check = true
			if marker_death_check == true:
				tiles_with_markers.erase(cell)

func load_all_fish_markers():
	for key in fishable_tiles.keys():
		var new_marker = fish_marker.instantiate()
		add_child(new_marker)
		var water_direction = fishable_tiles[key]
		var cell = key
		var local_cell_position = map.map_to_local(cell)
		var global_cell_position = map.to_global(local_cell_position)
		new_marker.global_position = global_cell_position
		if water_direction == "Up" or water_direction == "Down":
			new_marker.rotate(1.5708)
		new_marker.fishing_area.direction_of_water = water_direction

func load_fish_markers():
	if get_child_count() >= 10:
		return
	var fish_markers_to_load = max_fish_markers - get_child_count()
	for n in fish_markers_to_load:
		var random_cell = fishable_tiles.keys()[randi_range(0, fishable_tiles.keys().size() - 1)]
		while tiles_with_markers.find(random_cell) != -1:
			random_cell = fishable_tiles.keys()[randi_range(0, fishable_tiles.keys().size() - 1)]
		var cell = random_cell
		var water_direction = fishable_tiles[cell]
		var local_cell_position = map.map_to_local(cell)
		var global_cell_position = map.to_global(local_cell_position)
		if excluded_cells.find(global_cell_position) != -1:
			return
		var new_marker = fish_marker.instantiate()
		add_child(new_marker)
		new_marker.global_position = global_cell_position
		if water_direction == "Up" or water_direction == "Down":
			new_marker.rotate(1.5708)
		new_marker.fishing_area.direction_of_water = water_direction
		tiles_with_markers.append(new_marker.global_position)
		excluded_cells.append(new_marker.global_position)



func exclude_cell(node: Node2D):
	var excluded_cell_global_position = node.global_position
	await get_tree().create_timer(5).timeout
	excluded_cells.erase(excluded_cell_global_position)


func _on_marker_exiting_tree(node: Node) -> void:
	print("marker exited")
