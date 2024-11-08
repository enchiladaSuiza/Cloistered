extends Area2D

class_name Damage

signal hit

@export var damage_value: int = 1

func _on_area_entered(area: Area2D) -> void:
	if area is Hurt:
		hit.emit()
