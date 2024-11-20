extends Node

var entrance = {
	"keys_left": 3,
	"door_open": false
}:
	get():
		return entrance
	set(value):
		entrance = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
