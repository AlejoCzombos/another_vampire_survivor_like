class_name GlobalsSFX
extends Node

@onready var enemy_hit_sfx: AudioStreamPlayer2D = $Enemies/EnemyHitSFX
@onready var enemy_died_sfx: AudioStreamPlayer2D = $Enemies/EnemyDiedSFX

@onready var coin_collected_sfx: AudioStreamPlayer2D = $Player/CoinCollectedSFX


func play_enemy_hit() -> void:
	if enemy_hit_sfx.stream:
		enemy_hit_sfx.play()

func play_enemy_died() -> void:
	if enemy_died_sfx.stream:
		enemy_died_sfx.play()

func play_coin_collected() -> void:
	if coin_collected_sfx.stream:
		coin_collected_sfx.play()
