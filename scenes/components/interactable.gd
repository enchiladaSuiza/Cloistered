extends Area2D

class_name Interactable

signal interacted(player_inventory: Array)

@export var consumable_item: String:
	get():
		return consumable_item
	set(value):
		consumable_item = value

func interact(player_inventory):
	interacted.emit(player_inventory)
