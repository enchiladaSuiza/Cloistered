extends Area2D

class_name Hurt

signal damage_taken(value: int)

var damage_areas_inside = []
var areas_to_ignore = []

func add_area_to_ignore(area: Area2D):
	areas_to_ignore.append(area)

func _on_area_entered(area: Area2D) -> void:
	if area in areas_to_ignore:
		return
	if area is Damage:
		damage_taken.emit(area.damage_value)
		damage_areas_inside.append(area)

func _on_area_exited(area):
	if area is Damage:
		damage_areas_inside.erase(area)
