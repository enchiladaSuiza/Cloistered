extends Area2D

class_name Damage

signal hit(area: Area2D)
signal entered_collision(body: Node2D)

@export var damage_value: float = 1:
	get():
		return damage_value
var areas_to_ignore = []

func add_area_to_ignore(area: Area2D):
	areas_to_ignore.append(area)

func _on_area_entered(area: Area2D) -> void:
	if area in areas_to_ignore:
		return
	if area is Hurt:
		hit.emit(area)

func _on_body_entered(body: Node2D) -> void:
	entered_collision.emit(body)
