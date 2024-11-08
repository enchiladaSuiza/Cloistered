extends Node2D

@export var speed: float = 500.0
var direction := Vector2.ZERO:
	get:
		return direction
	set(value):
		direction = value
const live_length: float = 10000
const live_height: float = 10000

func _process(delta):
	self.position += direction * speed * delta
	if abs(position.x) > live_length or abs(position.y) > live_height:
		queue_free() 

func _on_damagebox_hit() -> void:
	queue_free()
