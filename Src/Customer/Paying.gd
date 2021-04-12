extends State

# Where the customer can go.
var path = []
var path_idx = 0


func get_direction() -> Vector3:
	if path_idx < path.size():
		var current_target: Vector3 = path[path_idx]
		if current_target.distance_squared_to(owner.global_transform.origin) < 0.5:
			path_idx += 1
			return Vector3.ZERO
		else:
			return owner.global_transform.origin.direction_to(current_target)
	else:
		return Vector3.ZERO

func compute_path(t: Vector3):
	path = owner.navigation.get_simple_path(owner.global_transform.origin, t)
	path_idx = 0


func enter(msg := {}) -> void:
	
	var curves = get_tree().get_nodes_in_group("Queue")
	assert(curves.size() > 0)
	
	var first_available = 100
	var queue = null
	for curve in curves:	
		if curve.first_available < first_available:
			first_available = curve.first_available
			queue = curve
			
	# Queue should not be null here or that's a coding error
	var pos = queue.reserve_spot(self)
	compute_path(pos)


func physics_update(delta: float) -> void:
	var dir = get_direction()

	if dir.x != 0.0 or dir.z != 0.0:
		owner.look_at(owner.global_transform.origin +Vector3(dir.x, 0.0, dir.z), Vector3.UP)
	
	owner.velocity = owner.velocity.linear_interpolate(dir * owner.speed, delta * 10.0)

func move_to_exit():
	state_machine.transition_to("LeaveShop")
