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
		return pos

func is_customer_waiting() -> bool:
	return first_available > 0
	
func get_first_customer() -> Node:
	return customers_in_line[0]

func process_first_customer():
	var processed = get_first_customer()
	processed.move_to_exit()
	# rotating array would be better here, but it's ok.
	for i in range(1, first_available):
		customers_in_line[i-1] = customers_in_line[i]
		customers_in_line[i-1].compute_path(get_child(i-1).global_transform.origin)
	first_available -= 1
