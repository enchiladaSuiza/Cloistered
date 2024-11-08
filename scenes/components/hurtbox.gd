extends Area2D

class_name Hurt

signal hp_changed(value: int)

@export var hp: int = 10

func _on_area_entered(area: Area2D) -> void:
	if area is Damage:
		hp -= area.damage_value
		hp_changed.emit(hp)
