class_name EnemyBase
extends Sprite2D

enum STATE {
	SPAWNING,
	LIVE,
	DEAD
}

var object: RID
var shape: RID

var current_state: STATE = STATE.LIVE
var target: Player
var speed: float = 30

func _ready() -> void:
	target = Globals.get_player()
	
	var physics_server := PhysicsServer2D
	object = physics_server.body_create()
	
	shape = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(shape, 6)
	PhysicsServer2D.body_add_shape(object, shape)
	
	physics_server.body_set_space(object, get_world_2d().space)
	
	#var transform: Transform2D = Transform2D(0, global_position)
	var trans: Transform2D = Transform2D(0, global_position)
	physics_server.body_set_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM, trans)
	physics_server.body_set_mode(object, PhysicsServer2D.BODY_MODE_RIGID_LINEAR)
	physics_server.body_set_param(object, PhysicsServer2D.BODY_PARAM_GRAVITY_SCALE, 0.0)
	
	physics_server.body_set_collision_layer(object, 3 | 4)
	physics_server.body_set_collision_mask(object, 4 | 3)
	await get_tree().process_frame
	
	PhysicsServer2D.body_attach_object_instance_id(object, get_instance_id())
	
	#state_controller(STATE.LIVE)

func _physics_process(_delta: float) -> void:
	if current_state == STATE.LIVE:
		var direction: Vector2 = global_position.direction_to(target.global_position).normalized()
		PhysicsServer2D.body_set_state(object, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, direction * speed)
	else:
		PhysicsServer2D.body_set_state(object, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, Vector2.ZERO)
	
	var transform: Transform2D = PhysicsServer2D.body_get_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM)
	global_transform = transform

func state_controller(new_state: STATE) -> void:
	if new_state == current_state:
		return
	
	match new_state:
		STATE.SPAWNING:
			pass
		STATE.LIVE:
			var transform: Transform2D = Transform2D(0, global_position)
			PhysicsServer2D.body_set_state(object, PhysicsServer2D.BODY_STATE_TRANSFORM, transform)
			PhysicsServer2D.body_set_mode(object, PhysicsServer2D.BODY_MODE_RIGID_LINEAR)
			
			await get_tree().process_frame
			PhysicsServer2D.body_attach_object_instance_id(object, get_instance_id())
		STATE.DEAD:
			PhysicsServer2D.body_set_state(object, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, Vector2.ZERO)
			PhysicsServer2D.body_set_mode(object, PhysicsServer2D.BODY_MODE_STATIC)
			queue_free()
		_:
			printerr("Estado inválido")
	current_state = new_state

func take_damage(_damage: float) -> void:
	Events.enemy_died.emit(global_position)
	queue_free()

func _exit_tree() -> void:
	PhysicsServer2D.free_rid(object)
