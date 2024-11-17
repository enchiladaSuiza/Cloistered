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
var current_floor: int = 0:
	get():
		return current_floor
	set(value):
		current_floor = value

func _process(delta):
	self.position += direction * speed * delta
	if abs(position.x) > live_length or abs(position.y) > live_height:
		queue_free() 

func ignore_area(area: Area2D):
	$Damagebox.add_area_to_ignore(area)

func _on_damagebox_hit(area: Area2D) -> void:
	queue_free()

func _on_damagebox_entered_collision(body: Node2D) -> void:
	#print("Pellet entered collision")
	if body is TileMapLayer:
		queue_free()
	if body is Ledge:
		if body.floor_index > current_floor:
			queue_free()
	
