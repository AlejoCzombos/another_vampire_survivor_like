extends Node
class_name EnemyManager

@onready var experience_coin: PackedScene = preload("res://entities/experiences/experience_coin.tscn")
@onready var damage_label: PackedScene = preload("res://scenes/particles/damage_label/damage_label.tscn")

func _ready() -> void:
	Events.on_enemy_died.connect(enemy_died)
	Events.on_enemy_hit.connect(enemy_hit) 

func enemy_died(position: Vector2) -> void:
	spawn_experience_coin(position)
	play_enemy_died()


func enemy_hit(position: Vector2, damage: float, is_critic: bool) -> void:
	spawn_damage_label(position, damage, is_critic)
	play_enemy_hit()


func spawn_experience_coin(position: Vector2) -> void:
	var new_coin: ExperienceCoin = experience_coin.instantiate()
	new_coin.global_position = position
	get_tree().current_scene.call_deferred("add_child", new_coin)


func spawn_damage_label(position: Vector2, damage: float, is_critic: bool) -> void:
	var new_damage_label: DamageLabel  = damage_label.instantiate()
	new_damage_label.global_position = position
	new_damage_label.set_label(int(damage), is_critic)
	get_tree().current_scene.call_deferred("add_child", new_damage_label)


func play_enemy_hit() -> void:
	GlobalSFX.play_enemy_hit()

func play_enemy_died() -> void:
	GlobalSFX.play_enemy_died()