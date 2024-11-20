extends Node2D

@export var camera_limits = {
	'left': -400,
	'top': -1700,
	'right': 400,
	'bottom': 400
}

func _ready() -> void:
	PlayerVariables.retrieve($Player)
	$Player.set_camera_limits(
		camera_limits['left'], camera_limits['top'],
		camera_limits['right'], camera_limits['bottom'])

func _on_entrance_area_trigger_area_entered(area):
	if area.get_parent() is Player:
		PlayerVariables.save($Player, Vector2(0, -1545))
		get_tree().call_deferred("change_scene_to_packed",
			load("res://scenes/entrance.tscn"))
