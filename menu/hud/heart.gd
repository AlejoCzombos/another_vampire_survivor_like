extends TextureRect
class_name Heart

@export var full_texture: Texture2D
@export var half_texture: Texture2D
@export var empty_texture: Texture2D

func set_heart_state(value: int) -> void:
	# 2 = full, 1 = half, 0 = empty
	match value:
		2:
			texture = full_texture
		1:
			texture = half_texture
		_:
			texture = empty_texture
