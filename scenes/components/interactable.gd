extends Area2D

class_name Interactable

signal interacted(player_inventory: Array)

@export var consumable_items: Array:
	get():
		return consumable_items
	set(value):
		consumable_items = value

func interact(player_inventory):
	interacted.emit(player_inventory)
