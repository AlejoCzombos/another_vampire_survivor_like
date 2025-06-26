extends Node
class_name GameManager

@export var hud_manager: HUDManager
@export var enemy_manager: EnemyManager
@export var spawn_manager: SpawnManager

func _ready() -> void:
	Events.on_experience_collected.connect(on_experience_collected)
	Events.on_level_up.connect(on_level_up)
	Events.on_upgrade_selected.connect(on_upgrade_selected)

func on_experience_collected() -> void:
	GlobalSFX.play_coin_collected()
	PlayerProperties.add_experience(10)

func on_level_up() -> void:
	GlobalSFX.play_level_up()
	hud_manager.show_upgrades_menu()
	get_tree().paused = true

func on_upgrade_selected() -> void:
	get_tree().paused = false
