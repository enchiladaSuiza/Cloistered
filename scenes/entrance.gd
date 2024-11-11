extends Node2D

# Detesto esta implementación
@export var camera_limits = {
	'left': -800,
	'top': -1500,
	'right': 800,
	'bottom': 120
}

func _ready() -> void:
	$Player.set_camera_limits(
		camera_limits['left'], camera_limits['top'], camera_limits['right'], camera_limits['bottom'])

func _process(delta: float) -> void:
	pass
