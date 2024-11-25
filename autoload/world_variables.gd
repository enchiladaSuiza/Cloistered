extends Node

var entrance = {
	"keys_left": 3,
	"door_open": false
}:
	get():
		return entrance
	set(value):
		entrance = value

func get_custom_data_at(tilemap: TileMapLayer, pos: Vector2, custom_data: String) -> Variant:
	var local_position: Vector2i = tilemap.local_to_map(pos)
	var data = tilemap.get_cell_tile_data(local_position)
	if data:
		return data.get_custom_data(custom_data)
	else:
		return 0

func change_scene(tree: SceneTree, player: Player, player_pos: Vector2, scene: PackedScene):
	PlayerVariables.save(player, player_pos)
	tree.call_deferred("change_scene_to_packed", scene)
