extends Node

var experience: int = 0
var level: int = 1
var experience_required: int = 100

const EXPERIENCE_GROWTH_RATE : float = 1.5


func add_experience(amount: int) -> void:
	experience += amount

	while experience >= experience_required:
		experience -= experience_required
		level += 1
		experience_required = int(experience_required * EXPERIENCE_GROWTH_RATE)
	
	Events.hud_refresh_experience.emit(level, experience, experience_required)
