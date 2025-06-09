class_name Player
extends CharacterBody2D

enum PLAYER_STATES {
	SPAWNING,
	LIVE,
	DEATH,
}

@export_group("Player atributes")
@export_range(0, 10, 0.1) var player_velocity: float = 5
@export var health: float = 10

@onready var sprite: Sprite2D = $Sprite
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var collision: CollisionShape2D = $Collision
@onready var spawn_path_follow: PathFollow2D = $SpawnPath/SpawnPathFollow

var current_state: int = PLAYER_STATES.SPAWNING

func _ready() -> void:
	Globals.set_player(self)

func state_controller(new_state: PLAYER_STATES) -> void:
	if new_state == current_state:
		return
	match new_state:
		PLAYER_STATES.SPAWNING:
			print('Spawning')
			pass
		PLAYER_STATES.LIVE:
			print('Live')
			pass
		PLAYER_STATES.DEATH:
			print('Death')
			pass
		_:
			printerr("ERROR ESTADO")
	current_state = new_state

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
		movement = movement.normalized() * player_velocity
		animation.play("run")
	else:
		if !animation.is_playing():
			animation.play("idle")
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0 :
		sprite.flip_h = false
	
	velocity = movement * 10
	move_and_slide()


func _on_pickup_area_body_entered(body: Node2D) -> void:
	body.attract_to_player(global_position)
