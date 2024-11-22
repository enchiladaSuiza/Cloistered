extends CanvasLayer

@export var player: Player

# Textures have to be 16x16
var textures = {
	"key": load("res://assets/key.png"),
	"dagger": load("res://assets/dagger.png"),
	"bread": load("res://assets/bread.png"),
	"chalice": load("res://assets/chalice.png"),
	"ring": load("res://assets/ring.png")
}

var inventory_x: = 12
var inventory_y := 348
var inventory_spacing := 2

func _ready():
	player.hp_changed.connect(self.hp_changed)
	player.inventory_updated.connect(self.update_inventory)
	$LifeBar.max_value = player.max_hp
	$LifeBar.value = player.hp
	$LifeBar/LifeLabel.text = str(player.hp) + "/" + str(player.max_hp)

func hp_changed(value: float):
	$LifeBar.value = value
	$LifeBar/LifeLabel.text = str(value) + "/" + str(player.max_hp)

func update_inventory(inventory: Array):
	for sprite in $Inventory.get_children():
		sprite.queue_free()
	
	var current_x = inventory_x
	for item in inventory: 
		var sprite = Sprite2D.new()
		sprite.texture = textures[item]
		sprite.position = Vector2(current_x, inventory_y)
		current_x += 16 + inventory_spacing
		$Inventory.add_child(sprite)
