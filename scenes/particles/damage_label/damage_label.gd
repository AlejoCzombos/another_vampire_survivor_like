class_name DamageLabel
extends Node2D

@export var gravity := Vector2(0, 980)

@onready var _label := $Label
@onready var _animation_player := $AnimationPlayer

var _velocity := Vector2.ZERO


func _init() -> void:
	set_as_top_level(true)


func _ready() -> void:
	_velocity = Vector2(randf_range(-50, 50), -150)


func _process(delta: float) -> void:
	_velocity += gravity * delta
	global_position += _velocity * delta
	

func set_label(amount: int, special: bool) -> void:
	if not _label:
		await ready
	
	if special:
		_label.add_theme_color_override("font_color", Constants.tertiary_color)
	
	_label.text = "-" + str(amount)
	_animation_player.play("show")
