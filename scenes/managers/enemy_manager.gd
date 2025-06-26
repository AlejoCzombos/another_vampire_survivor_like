extends Node
class_name EnemyManager

@export var experience_coin: PackedScene

func _ready() -> void:
	Events.on_enemy_died.connect(enemy_died)
	Events.on_enemy_hit.connect(play_enemy_hit)

func enemy_died(global_position: Vector2) -> void:
	spawn_experience_coin(global_position)
	play_enemy_died()

func spawn_experience_coin(position: Vector2) -> void:
	var new_coin: ExperienceCoin = experience_coin.instantiate()
	new_coin.global_position = position
	get_tree().current_scene.call_deferred("add_child", new_coin)

func play_enemy_hit() -> void:
	GlobalSFX.play_enemy_hit()

func play_enemy_died() -> void:
	GlobalSFX.play_enemy_died()
