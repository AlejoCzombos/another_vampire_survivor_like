class_name HUD
extends Control

@onready var heart_container: HeartsContainer = $MarginContainer/VBoxContainer/HBoxContainer/HeartContainer
@onready var experience_bar: TextureProgressBar = $MarginContainer/VBoxContainer/ExperienceBar
@onready var experience_label: Label = $MarginContainer/VBoxContainer/ExperienceBar/Level

func _ready() -> void:
	initialize_hud()
	Events.hud_refresh_experience.connect(refresh_experience)
	Events.hud_refresh_level.connect(on_level_up)
	Events.hud_refresh_health.connect(refresh_health)
	Events.hud_refresh_max_health.connect(refresh_max_health)


func initialize_hud() -> void:
	initialize_experience()
	initialize_health()

func initialize_experience() -> void:
	experience_bar.max_value = PlayerProperties.experience_required
	experience_bar.value = 0
	experience_label.text = str(PlayerProperties.level)

func refresh_experience(experience: int) -> void:
	experience_bar.value = experience

func on_level_up(new_level: int, new_experience_required: int) -> void:
	experience_label.text = str(new_level)
	experience_bar.max_value = new_experience_required
	experience_bar.value = 0

func initialize_health() -> void:
	heart_container.max_health = PlayerProperties.max_health
	heart_container.initialize_heart_container()

func refresh_health(current_health: int) -> void:
	heart_container.refresh_hearts(current_health)

func refresh_max_health(current_health: int, max_health: int) -> void:
	heart_container.refresh_max_health(current_health, max_health)
