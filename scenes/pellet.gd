extends Node2D

@export var speed: float = 500.0

var damagebox: Area2D:
	get():
		return $Damagebox

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

func ignore_area(area: Area2D):
	$Damagebox.add_area_to_ignore(area)

func _on_damagebox_hit(area: Area2D) -> void:
	queue_free()
