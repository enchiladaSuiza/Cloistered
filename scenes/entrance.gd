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

func _physics_process(delta: float) -> void:
	$Player.speed_modifier = get_custom_data_at($Player.position, "speed_modifier")

func get_custom_data_at(position: Vector2, custom_data: String) -> Variant:
	var local_position: Vector2i = $TileMapLayer.local_to_map(position)
	var data = $TileMapLayer.get_cell_tile_data(local_position)
	if data:
		return data.get_custom_data(custom_data)
	else:
		return 0

func _on_floor_0_trigger_body_entered(body):
	if body is Player:
		$Player.current_floor = 0
		enable_ledges.call_deferred()

func _on_floor_1_trigger_body_entered(body):
	if body is Player:
		$Player.current_floor = 1
		disable_ledges.call_deferred()

func enable_ledges():
	pass

func disable_ledges():
	pass
