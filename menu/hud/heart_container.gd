extends VFlowContainer
class_name HeartsContainer

@export var heart_scene: PackedScene
@export var max_health: int = 10
var heart_nodes: Array[Heart] = []

func _ready() -> void:
	for child: Heart in get_children():
		remove_child(child)
		child.queue_free()

func initialize_heart_container() -> void:
	var heart_count: int = int(ceil(max_health / 2.0))
	for i: int in heart_count:
		var heart: Heart = heart_scene.instantiate()
		add_child(heart)
		heart_nodes.append(heart)

func refresh_hearts(current_health: int) -> void:
	for i: int in heart_nodes.size():
		var heart_val: int = clamp(current_health - (i * 2), 0, 2)
		heart_nodes[i].set_heart_state(heart_val)

func refresh_max_health(current_health: int, new_max_health: int) -> void:
	self.max_health = new_max_health
	for heart: Heart in heart_nodes:
		heart.queue_free()
	heart_nodes.clear()

	initialize_heart_container()
	refresh_hearts(current_health)