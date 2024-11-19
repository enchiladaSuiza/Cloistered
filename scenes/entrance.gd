extends Node2D

# Detesto esta implementación
@export var camera_limits = {
	'left': -800,
	'top': -1700,
	'right': 800,
	'bottom': 120
}

func _ready() -> void:
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

func _on_plank_locks_unlocked():
	open_door()

func _on_church_area_trigger_area_entered(area):
	print("going to church")
