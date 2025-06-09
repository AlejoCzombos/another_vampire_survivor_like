extends Node

var player: Player : get = get_player, set = set_player

func get_player() -> Player:
	return player

func set_player(new_player: Player) -> void:
	player = new_player
