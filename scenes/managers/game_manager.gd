extends Node

func _ready() -> void:
	Events.experience_collected.connect(add_experience)

func add_experience() -> void:
	PlayerProperties.add_experience(10)
