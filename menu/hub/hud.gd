class_name HUD
extends Control

@onready var experience_bar: ProgressBar = $MarginContainer/VBoxContainer/ExperienceBar
@onready var experience_label: Label = $MarginContainer/VBoxContainer/ExperienceBar/Label

func _ready() -> void:
    initialize_hud()
    Events.hud_refresh_experience.connect(refresh_experience)


func initialize_hud() -> void:
    var initial_expecience_level: int = PlayerProperties.level
    var initial_experience: int = PlayerProperties.experience
    var initial_experience_required: int = PlayerProperties.experience_required
    refresh_experience(initial_expecience_level, initial_experience, initial_experience_required)

# TODO: Make a function for refreshing experience and for level up separately
func refresh_experience(level: int, experience: int, experience_required: int) -> void:
    experience_bar.max_value = experience_required
    experience_bar.value = experience
    experience_label.text = str(level)
