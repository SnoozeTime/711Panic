extends CustomerState

var waiting_time: float = 0.0

var position_in_queue = -1

var queue = null

func reset_patience():
	waiting_time = 0

func enter(_msg := {}) -> void:
	waiting_time = 0
	
	var curves = get_tree().get_nodes_in_group("Queue")
	assert(curves.size() > 0)
	
	var first_available = 100
	for curve in curves:	
		if curve.first_available < first_available:
			first_available = curve.first_available
			queue = curve
			
	# Queue should not be null here or that's a coding error
	var queue_ret = queue.reserve_spot(self)
	var pos = queue_ret[0]
	position_in_queue = queue_ret[1]
	compute_path(pos)


func move_to_exit():
	state_machine.transition_to("LeaveShop")

func update(delta: float) -> void:
	waiting_time += delta
	
	if waiting_time >= owner.max_waiting_time:
		queue.on_customer_leave(position_in_queue)
		state_machine.transition_to("LeaveShop")
