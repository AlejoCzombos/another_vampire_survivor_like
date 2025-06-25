class_name Player
extends CharacterBody2D

enum PLAYER_STATES {
	SPAWNING,
	LIVE,
	HURT,
	DEATH,
}

@onready var sprite: Sprite2D = $Sprite
@onready var camera: Camera2D = $Camera
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var collision: CollisionShape2D = $Collision
@onready var spawn_path_follow: PathFollow2D = $SpawnPath/SpawnPathFollow
@onready var i_frames_timer: Timer = $IFramesTimer

@onready var weapon: WeaponBase = $Weapons/FireBaculum

var animation_state: AnimationNodeStateMachinePlayback

var damage: float
var health: int
var move_speed: float
var attack_cooldown: float
var crit_multiplier: float

var current_state: int = PLAYER_STATES.SPAWNING

func _ready() -> void:
	Globals.set_player(self)
	state_controller(PLAYER_STATES.LIVE)
	initialize_properties()
	animation_state = animation_tree["parameters/playback"]


func _process(_delta: float) -> void:
	var movement: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		movement.y = -1
	if Input.is_action_pressed("down"):
		movement.y = 1
	if Input.is_action_pressed("right"):
		movement.x = 1
	if Input.is_action_pressed("left"):
		movement.x = -1
	
	if movement.length() > 0:
		movement = movement.normalized() * move_speed
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0 :
		sprite.flip_h = false
	
	velocity = movement * 10
	move_and_slide()

func initialize_properties() -> void:
	damage = PlayerProperties.damage
	health = PlayerProperties.health
	move_speed = PlayerProperties.move_speed
	attack_cooldown = PlayerProperties.attack_cooldown
	crit_multiplier = PlayerProperties.crit_multiplier
	
	weapon.update_properties(attack_cooldown, damage)


func update_properties(
	new_damage: float,
	new_health: int,
	new_attack_cooldown: float,
	new_crit_multiplier: float
) -> void:
	damage = new_damage
	health = new_health
	attack_cooldown = new_attack_cooldown
	crit_multiplier = new_crit_multiplier
	
	weapon.update_properties(attack_cooldown, damage)


func _on_pickup_area_body_entered(body: Node2D) -> void:
	body.attract_to_player(global_position)


func _on_hit_area_body_entered(_body: Node2D) -> void:
	if current_state == PLAYER_STATES.HURT or current_state == PLAYER_STATES.DEATH:
		return
	
	health -= 1
	if health <= 0:
		call_deferred("state_controller", PLAYER_STATES.DEATH)
		return
	
	call_deferred("state_controller", PLAYER_STATES.HURT)
	camera.start_shake()


func _on_i_frames_timer_timeout() -> void:
	state_controller(PLAYER_STATES.LIVE)
	i_frames_timer.stop()


func state_controller(new_state: PLAYER_STATES) -> void:
	if new_state == current_state:
		return
	match new_state:
		PLAYER_STATES.SPAWNING:
			pass
		PLAYER_STATES.LIVE:
			collision.disabled = false
			pass
		PLAYER_STATES.HURT:
			animation_state.travel("hit")
			i_frames_timer.start()
			collision.disabled = true
		PLAYER_STATES.DEATH:
			collision.disabled = true
			pass
		_:
			printerr("STATE ERROR")
	current_state = new_state
	#print_player_state()


func print_player_state() -> void:
	print("♣️ Player state: ", PLAYER_STATES.find_key(current_state))
