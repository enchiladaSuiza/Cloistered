extends StaticBody2D

func _on_interactable_interacted(player_inventory):
	$Sprites.play("open")
	$Collision.disabled = true
