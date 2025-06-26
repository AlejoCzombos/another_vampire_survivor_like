class_name GlobalsSFX
extends Node

@onready var enemy_hit_sfx: AudioStreamPlayer2D = $Enemies/EnemyHitSFX
@onready var enemy_died_sfx: AudioStreamPlayer2D = $Enemies/EnemyDiedSFX

@onready var coin_collected_sfx: AudioStreamPlayer2D = $Player/CoinCollectedSFX
@onready var level_up_sfx: AudioStreamPlayer2D = $Player/LevelUpSFX


func play_enemy_hit() -> void:
	if enemy_hit_sfx.stream:
		enemy_hit_sfx.play()

func play_enemy_died() -> void:
	if enemy_died_sfx.stream:
		enemy_died_sfx.play()

var delay: Array[float] = [0.0, 0.02, 0.04, 0.06, 0.08]

func play_coin_collected() -> void:
	if coin_collected_sfx.stream:
		if coin_collected_sfx.playing:
			await get_tree().create_timer(delay.pick_random()).timeout
		coin_collected_sfx.play()

func play_level_up() -> void:
	if level_up_sfx.stream:
		level_up_sfx.play()
