extends Spatial
class_name Queue


var customers_in_line = []
var first_available = 0

func _ready():
	for _i in (get_child_count()):
		customers_in_line.append(null)

func reserve_spot(node):
	if first_available == customers_in_line.size():
		return null
	else:
		customers_in_line[first_available] = node
		var pos = get_child(first_available).global_transform.origin	

		first_available += 1	
		return [pos, first_available - 1]

func is_customer_waiting() -> bool:
	return first_available > 0
	
func get_first_customer() -> Node:
	return customers_in_line[0]

func process_first_customer():
	var processed = get_first_customer()
	if processed != null:
		processed.move_to_exit()
		# rotating array would be better here, but it's ok.
		for i in range(1, first_available):
			customers_in_line[i-1] = customers_in_line[i]
			customers_in_line[i-1].compute_path(get_child(i-1).global_transform.origin)
			customers_in_line[i-1].reset_patience()
			customers_in_line[i-1].position_in_queue = i-1
		first_available -= 1

func on_customer_leave(idx):
	if customers_in_line[idx] != null:
		for i in range(idx+1, first_available):
			customers_in_line[i-1] = customers_in_line[i]
			customers_in_line[i-1].compute_path(get_child(i-1).global_transform.origin)
			customers_in_line[i-1].reset_patience()
			customers_in_line[i-1].position_in_queue = i-1
		first_available -= 1

func reset_first_customer_patience():
	""" This is used when the player starts making the customer pay. So that the
	customer won't leave in the middle of the checkout.
	"""
	customers_in_line[0].reset_patience()
	
func empty():
	for i in range(customers_in_line.size()):
		customers_in_line[i] = null
