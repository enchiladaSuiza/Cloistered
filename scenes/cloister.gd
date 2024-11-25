extends Node2D

@export var camera_limits = {
	'left': -100,
	'top': -1000,
	'right': 1000,
	'bottom': 1000
}

func _ready():
	PlayerVariables.retrieve($Player)
	$Player.set_camera_limits(camera_limits)
