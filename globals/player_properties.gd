extends Node

var damage: float = 2.0
var max_health: int = 6
var health: int = 6
var move_speed: float = 10
var attack_cooldown: float = 2
var crit_multiplier: float = 2
var crit_probability: float = 0.1

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
		Events.hud_refresh_level.emit(level, experience_required)
		Events.on_level_up.emit()
	
	Events.hud_refresh_experience.emit(experience)

func update_health(current_health: int) -> void:
	health = current_health
	Events.hud_refresh_health.emit(health)

func apply_upgrade(upgrade: UpgradeResource) -> void:
	var player: Player = Globals.get_player()

	match upgrade.upgrade_type:

		UpgradeResource.UpgradeType.DAMAGE:
			var percentaje: float = upgrade.upgrade_value / 100
			damage += (damage * percentaje)
		
		UpgradeResource.UpgradeType.HEALTH:
			max_health += int(upgrade.upgrade_value)
			health += int(upgrade.upgrade_value)
			Events.hud_refresh_max_health.emit(health, max_health)
		
		UpgradeResource.UpgradeType.SPEED:
			var percentaje: float = upgrade.upgrade_value / 100
			move_speed += (move_speed * percentaje)
		
		UpgradeResource.UpgradeType.ATTACK_SPEED:
			var percentaje: float = upgrade.upgrade_value / 100
			attack_cooldown -= (attack_cooldown * percentaje)
		
		UpgradeResource.UpgradeType.CRITIC_DAMAGE:
			var percentaje: float = upgrade.upgrade_value / 100
			crit_multiplier += (crit_multiplier * percentaje)
		
		_:
			printerr("Unknown upgrade type: ", upgrade.upgrade_type)
	
	player.update_properties(
		damage,
		health,
		move_speed,
		attack_cooldown,
		crit_multiplier
	)

func is_critic_damage() -> bool:
	return randi()
	return true
