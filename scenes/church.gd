extends Node2D

@export var camera_limits = {
	'left': -400,
	'top': -1700,
	'right': 400,
	'bottom': 400
}

var puzzle = [false, false, false, false]

func _ready() -> void:
	PlayerVariables.retrieve($Player)
	$Player.set_camera_limits(camera_limits)
	$Pedestal.return_item.connect($Player.give_item)
	$Pedestal2.return_item.connect($Player.give_item)
	$Pedestal3.return_item.connect($Player.give_item)
	$Pedestal4.return_item.connect($Player.give_item)
	$Pedestal.item_placed.connect(pedestal_1_changed)
	$Pedestal2.item_placed.connect(pedestal_2_changed)
	$Pedestal3.item_placed.connect(pedestal_3_changed)
	$Pedestal4.item_placed.connect(pedestal_4_changed)

func _physics_process(_delta: float) -> void:
	$Player.speed_modifier = WorldVariables.get_custom_data_at($TileMapLayer, $Player.position, "speed_modifier")

func _on_entrance_area_trigger_area_entered(area):
	WorldVariables.change_scene(
			get_tree(),
			area.get_parent() as Player,
			Vector2(0, -1545),
			load("res://scenes/entrance.tscn"))

func _on_cloister_area_trigger_area_entered(area):
	WorldVariables.change_scene(
			get_tree(),
			area.get_parent() as Player,
			Vector2.ZERO,
			load("res://scenes/cloister.tscn"))

func pedestal_1_changed(correct: bool):
	puzzle[0] = correct
	check_puzzle()
	
func pedestal_2_changed(correct: bool):
	puzzle[1] = correct
	check_puzzle()
	
func pedestal_3_changed(correct: bool):
	puzzle[2] = correct
	check_puzzle()
	
func pedestal_4_changed(correct: bool):
	puzzle[3] = correct
	check_puzzle()
	
func check_puzzle():
	for item in puzzle:
		if !item:
			return
	open_door()

func open_door():
	# Turn on candles
	for y in range(-47, -4, 4):
		$TileMapLayer3.set_cell(Vector2(-5, y), 0, Vector2(1, 0))
	for y in range(-47, -4, 4):
		$TileMapLayer3.set_cell(Vector2(4, y), 0, Vector2(1, 0))
	# Open door
	$TileMapLayer2.set_cell(Vector2(18, -32), 2, Vector2(1, 1), 1)
	$TileMapLayer2.set_cell(Vector2(19, -32), 2, Vector2(1, 2), 1)
	$TileMapLayer2.set_cell(Vector2(20, -32), 2, Vector2(1, 0), 1)
	$TileMapLayer2.set_cell(Vector2(18, -31), 2, Vector2(1, 1), 2)
	$TileMapLayer2.set_cell(Vector2(19, -31), 2, Vector2(1, 2), 2)
	$TileMapLayer2.set_cell(Vector2(20, -31), 2, Vector2(1, 0), 2)
