extends Node2D

# Detesto esta implementación
@export var camera_limits = {
	'left': -800,
	'top': -1700,
	'right': 800,
	'bottom': 120
}

var save_variables = {
	"keys_left": 3,
	"door_open": false
}

var snake_scene := load("res://scenes/enemies/snake.tscn")
var plank_locks_scene := load("res://scenes/plank_locks.tscn")

func _ready() -> void:
	PlayerVariables.retrieve($Player)
	save_variables = WorldVariables.entrance
	var snake_positions = [Vector2(0, -1500), Vector2(-310, -980), Vector2(530, -1208)]
	for i in range(save_variables["keys_left"]):
		var snake = snake_scene.instantiate()
		snake.position = snake_positions[i]
		snake.dropped_scene = load("res://scenes/key.tscn")
		add_child(snake)
	if save_variables["door_open"]:
		open_door()
	else:
		var plank_locks = plank_locks_scene.instantiate()
		plank_locks.position = Vector2(0, -1588)
		plank_locks.unlocked.connect(open_door)
		add_child(plank_locks)
	
	$Player.set_camera_limits(
		camera_limits['left'], camera_limits['top'], camera_limits['right'], camera_limits['bottom'])

func _physics_process(_delta: float) -> void:
	$Player.speed_modifier = get_custom_data_at($Player.position, "speed_modifier")

func get_custom_data_at(pos: Vector2, custom_data: String) -> Variant:
	var local_position: Vector2i = $TileMapLayer.local_to_map(pos)
	var data = $TileMapLayer.get_cell_tile_data(local_position)
	if data:
		return data.get_custom_data(custom_data)
	else:
		return 0

func _on_floor_0_trigger_body_entered(body):
	if body is Player:
		$Player.current_floor = 0

func _on_floor_1_trigger_body_entered(body):
	if body is Player:
		$Player.current_floor = 1

# XD
func open_door():
	$TileMapLayer.set_cell(Vector2i(-2, -104), 0, Vector2i(2, 0))
	$TileMapLayer.set_cell(Vector2i(-1, -104), 0, Vector2i(3, 0))
	$TileMapLayer.set_cell(Vector2i(-2, -103), 0, Vector2i(2, 1))
	$TileMapLayer.set_cell(Vector2i(-1, -103), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(-2, -102), 0, Vector2i(2, 2))
	$TileMapLayer.set_cell(Vector2i(-1, -102), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(-2, -101), 0, Vector2i(2, 2))
	$TileMapLayer.set_cell(Vector2i(-1, -101), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(-2, -100), 0, Vector2i(2, 2))
	$TileMapLayer.set_cell(Vector2i(-1, -100), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(-2, -99), 0, Vector2i(2, 3))
	$TileMapLayer.set_cell(Vector2i(-1, -99), 1, Vector2i(0, 4))
	
	$TileMapLayer.set_cell(Vector2i(0, -104), 0, Vector2i(3, 0), 1)
	$TileMapLayer.set_cell(Vector2i(1, -104), 0, Vector2i(2, 0), 1)
	$TileMapLayer.set_cell(Vector2i(0, -103), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(1, -103), 0, Vector2i(2, 1), 1)
	$TileMapLayer.set_cell(Vector2i(0, -102), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(1, -102), 0, Vector2i(2, 2), 1)
	$TileMapLayer.set_cell(Vector2i(0, -101), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(1, -101), 0, Vector2i(2, 2), 1)
	$TileMapLayer.set_cell(Vector2i(0, -100), 0, Vector2i(3, 1))
	$TileMapLayer.set_cell(Vector2i(1, -100), 0, Vector2i(2, 2), 1)
	$TileMapLayer.set_cell(Vector2i(0, -99), 1, Vector2i(0, 4))
	$TileMapLayer.set_cell(Vector2i(1, -99), 0, Vector2i(2, 3), 1)
	
	save_variables["door_open"] = true

func _on_church_area_trigger_area_entered(area):
	if area.get_parent() is Player:
		PlayerVariables.save($Player)
		WorldVariables.entrance = save_variables
		get_tree().call_deferred("change_scene_to_packed",
			load("res://scenes/church.tscn"))

func _on_player_item_got(item_name):
	if item_name == "key":
		save_variables["keys_left"] -= 1
