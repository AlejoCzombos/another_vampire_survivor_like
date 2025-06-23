extends Node

var damage: float = 10.0
var max_health: int = 6
var health: int = 6
var move_speed: float = 200.0
var attack_cooldown: float = 0.5
var crit_multiplier: float = 0.1

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

func apply_upgrade(upgrade: UpgradeResource) -> void:
	match upgrade.upgrade_type:
		UpgradeResource.UpgradeType.DAMAGE:
			damage *= upgrade.upgrade_value
		UpgradeResource.UpgradeType.HEALTH:
			max_health += int(upgrade.upgrade_value)
			health += int(upgrade.upgrade_value)
		UpgradeResource.UpgradeType.SPEED:
			move_speed *= upgrade.upgrade_value
		UpgradeResource.UpgradeType.ATTACK_SPEED:
			attack_cooldown *= upgrade.upgrade_value
		UpgradeResource.UpgradeType.CRITIC_DAMAGE:
			crit_multiplier *= upgrade.upgrade_value
		_:
			printerr("Unknown upgrade type: ", upgrade.upgrade_type)
	
	# TODO: Emit signal for upgrade applied and for apply upgrades in the player