extends StaticBody2D

signal unlocked

func _on_interactable_interacted(player_inventory):
	if "key" in player_inventory:
		$Locks.get_children()[0].queue_free()
		print($Locks.get_child_count())
		if $Locks.get_child_count() <= 1:
			unlocked.emit()
			queue_free()
