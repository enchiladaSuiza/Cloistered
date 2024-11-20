extends Node

var hp: float
var max_hp: float
var position: Vector2

var have_retrieved_once = false

func retrieve(player: Player):
	if have_retrieved_once:
		player.hp = hp
		player.max_hp = max_hp
		player.position = position
		return
	save(player)
	have_retrieved_once = true
		
func save(player: Player, position: Vector2 = Vector2.ZERO):
	hp = player.hp
	max_hp = player.max_hp
	self.position = position
	print_variables()

func print_variables():
	print("HP: " + str(hp))
	print("Max HP: " + str(max_hp))
	print("Position" + str(position))
