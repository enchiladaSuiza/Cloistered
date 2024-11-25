extends Sprite2D

signal return_item(item: String)
signal item_placed(correct: bool)

var holdables = {
	"dagger": load("res://assets/dagger.png"),
	"bread": load("res://assets/bread.png"),
	"chalice": load("res://assets/chalice.png"),
	"ring": load("res://assets/ring.png")
}
var holding = false
var current_item: String

@export var correct_item: String

func _on_interactable_interacted(player_inventory: Array) -> void:
	if holding:
		return_item.emit(current_item)
		current_item = ""
		$HoldableItem.texture = null
		holding = false
		$Interactable.consumable_items = holdables.keys()
		return
	for item in player_inventory:
		if item in $Interactable.consumable_items:
			item_placed.emit(item == correct_item)
			$HoldableItem.texture = holdables[item]
			current_item = item
			holding = true
			$Interactable.consumable_items = []
			break
