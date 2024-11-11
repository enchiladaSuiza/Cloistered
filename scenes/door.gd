extends Node2D

func _ready():
	pass

func _process(delta):
	pass

func _on_interactable_interacted():
	$Sprites.play("open")
	$Collision.disabled = true
