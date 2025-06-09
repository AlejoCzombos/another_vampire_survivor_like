class_name ProjectilBase
extends Area2D

var velocity: Vector2 = Vector2.ZERO
var damage: float

func _physics_process(delta: float) -> void:
	position += velocity * delta

func instantiate(
	pos: Vector2,
	direction: float,
	vel: float,
	dm:float
) -> void:
	position = pos
	rotation = direction
	velocity = Vector2(vel, 0).rotated(direction)
	damage = dm

func try_deal_damage(entity: Node2D) -> void:
	if entity.has_method("take_damage"):
		entity.take_damage(damage)
	queue_free()

func _on_visible_on_screen_notifier_screen_exited() -> void:
	queue_free()

func _on_area_entered(entity: Area2D) -> void:
	try_deal_damage(entity)

func _on_body_entered(entity: Node2D) -> void:
	try_deal_damage(entity)
