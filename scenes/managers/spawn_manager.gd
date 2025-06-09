class_name SpawnManager
extends Node

@export var enemy : PackedScene

var player: Player
var path_follow: PathFollow2D

func _ready() -> void:
	player = Globals.get_player()
	path_follow = player.spawn_path_follow
	randomize()


func calculate_next_spawn() -> Vector2:
	path_follow.progress_ratio = randf()
	return path_follow.global_position


func spawn_enemy() -> void:
	var new_enemy: EnemyBase = enemy.instantiate()
	new_enemy.global_position = calculate_next_spawn()
	get_tree().current_scene.add_child(new_enemy)


func _on_spawn_cool_down_timeout() -> void:
	spawn_enemy()
