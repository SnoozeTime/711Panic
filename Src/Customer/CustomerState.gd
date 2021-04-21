class_name CustomerState
extends State

# FOR PATHFINDING
# Where the customer can go.
var path = []
var path_idx = 0


func get_direction() -> Vector3:
	if path_idx < path.size():
		var current_target: Vector3 = path[path_idx]
		if current_target.distance_squared_to(owner.global_transform.origin) < 2.0:
			path_idx += 1
			return Vector3.ZERO
		else:
			return owner.global_transform.origin.direction_to(current_target)
	else:
		return Vector3.ZERO

func compute_path(pos):
	path = owner.navigation.get_simple_path(owner.global_transform.origin, pos)
	path_idx = 0



func physics_update(delta: float) -> void:
	var dir = get_direction()

	if dir.x != 0.0 or dir.z != 0.0:
		owner.look_at(owner.global_transform.origin +Vector3(dir.x, 0.0, dir.z), Vector3.UP)
	
	owner.velocity = owner.velocity.linear_interpolate(dir * owner.speed, delta * 10.0)
