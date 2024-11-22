extends Sprite2D

signal return_item(item: String)

var holdables = {
	"dagger": load("res://assets/dagger.png"),
	"bread": load("res://assets/bread.png"),
	"chalice": load("res://assets/chalice.png"),
	"ring": load("res://assets/ring.png")
}
var holding = false

@export var holdable: String

func _ready():
	$Interactable.consumable_item = holdable

func _on_interactable_interacted(player_inventory: Array) -> void:
	if holding:
		$Interactable.consumable_item = ""
		$HoldableItem.texture = null
		return_item.emit(holdable)
		holding = false
		return
	if holdable in player_inventory:
		$Interactable.consumable_item = holdable
		$HoldableItem.texture = holdables[holdable]
		holding = true
