extends Node

var damage: float = 10.0
var max_health: int = 6
var health: int = 6
var move_speed: float = 10
var attack_cooldown: float = 2
var crit_multiplier: float = 0.1

var experience: int = 0
var level: int = 1
var experience_required: int = 100

#var player: Player

const EXPERIENCE_GROWTH_RATE : float = 1.5


func add_experience(amount: int) -> void:
	experience += amount

	while experience >= experience_required:
		experience -= experience_required
		level += 1
		experience_required = int(experience_required * EXPERIENCE_GROWTH_RATE)
	
	Events.hud_refresh_experience.emit(level, experience, experience_required)

func apply_upgrade(upgrade: UpgradeResource) -> void:
	var player = Globals.get_player()
	match upgrade.upgrade_type:
		UpgradeResource.UpgradeType.DAMAGE:
			var percentaje = upgrade.upgrade_value / 100
			damage += (damage * percentaje) 
			player.damage = damage
		
		UpgradeResource.UpgradeType.HEALTH:
			max_health += int(upgrade.upgrade_value)
			health += int(upgrade.upgrade_value)
			player.health = health
		
		UpgradeResource.UpgradeType.SPEED:
			var percentaje = upgrade.upgrade_value / 100
			move_speed += (move_speed * percentaje)
			player.move_speed = move_speed
		
		UpgradeResource.UpgradeType.ATTACK_SPEED:
			var percentaje = upgrade.upgrade_value / 100
			attack_cooldown -= (attack_cooldown * percentaje)
			player.attack_cooldown = attack_cooldown
		
		UpgradeResource.UpgradeType.CRITIC_DAMAGE:
			var percentaje = upgrade.upgrade_value / 100
			crit_multiplier += (crit_multiplier * percentaje)
			player.crit_multiplier = crit_multiplier
		
		_:
			printerr("Unknown upgrade type: ", upgrade.upgrade_type)
	player.update_properties(
		damage,
		health,
		attack_cooldown,
		crit_multiplier
	)
