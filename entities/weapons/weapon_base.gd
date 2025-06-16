class_name WeaponBase
extends Area2D

enum STATE {
	SHOOTING,
	COOLDOWN
}

@export var projectile: PackedScene = null
@export var fire_rate: float = 1
@export var projectile_speed: int = 200
@export var projectile_damage: float = 1

@onready var shoot_position: Marker2D = $ShootPosition
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var shoot_sfx: AudioStreamPlayer2D = $ShootSFX

var current_state: STATE = STATE.COOLDOWN


func _ready() -> void:
	cooldown_timer.wait_time = fire_rate
	cooldown_timer.start()


func shoot(rotarion: float) -> void:
	state_controller(STATE.COOLDOWN)

	shoot_sfx.play()

	var new_projectile: ProjectilBase = projectile.instantiate()
	new_projectile.instantiate(
		shoot_position.global_position,
		rotarion,
		projectile_speed,
		projectile_damage,
	)
	get_tree().current_scene.add_child(new_projectile)


func state_controller(new_state: STATE) -> void:
	if new_state == current_state:
		return
	
	match new_state:
		STATE.SHOOTING:
			pass
		STATE.COOLDOWN:
			cooldown_timer.start()
		_:
			printerr("Invalid weapon state")
	current_state = new_state

func _on_cooldown_timer_timeout() -> void:
	state_controller(STATE.SHOOTING)
