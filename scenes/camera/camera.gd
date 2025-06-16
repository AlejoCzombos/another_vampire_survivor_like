extends Camera2D

@onready var shake_timer: Timer = $TimerCameraShake

var shake_intensity: float = 0.0
var shake_duration: float = 0.0
var shake_elapsed: float = 0.0
var is_shaking: bool = false

var noise: FastNoiseLite = FastNoiseLite.new()

func _ready() -> void:
	Globals.camera = self
	noise.seed = randi()
	noise.frequency = 10.0
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX

func _exit_tree() -> void:
	if Globals.camera == self:
		Globals.camera = null

func _process(delta: float) -> void:
	var target_pos: Vector2 = Globals.get_player().global_position
	var local_offset: Vector2 = Vector2.ZERO

	if is_shaking:
		shake_elapsed += delta
		if shake_elapsed >= shake_duration:
			is_shaking = false
			shake_intensity = 0.0
		else:
			var t: float = Time.get_ticks_msec() / 100.0
			local_offset.x = noise.get_noise_1d(t) * shake_intensity
			local_offset.y = noise.get_noise_1d(t + 1000) * shake_intensity

	# Interpolamos suavemente hacia el objetivo con offset (si hay shake)
	global_position = lerp(global_position, target_pos + local_offset, 0.3)

	# Suavizar zoom
	zoom = lerp(zoom, Vector2.ONE, 0.1)

func start_shake(intensity: float = 5.0, duration: float = 0.4) -> void:
	shake_intensity = intensity
	shake_duration = duration
	shake_elapsed = 0.0
	is_shaking = true

	# Efecto de zoom leve por el impacto
	zoom = Vector2.ONE - Vector2(intensity * 0.03, intensity * 0.03)
