extends Node

@export var experience_coin: PackedScene

func _ready() -> void:
	Events.enemy_died.connect(spawn_experience_coin)


func spawn_experience_coin(position: Vector2) -> void:
	var new_coin: ExperienceCoin = experience_coin.instantiate()
	new_coin.global_position = position
	get_tree().current_scene.add_child(new_coin)
