extends Spatial

export var time_to_pay = 2.0 # seconds
var paying_time = 0
export var queue_path := NodePath()
onready var queue: Queue = get_node(queue_path)


var processing = false

func _process(delta):
	if processing:
		paying_time += delta
		
		if paying_time > time_to_pay:
			pay()
			
			
func pay():
	print("ALL PAYED")
	paying_time = 0
	# Get the customer and make hime leave.
	queue.process_first_customer()
	processing = false


func _on_Actionable_action_from_player(player):
	if queue.is_customer_waiting():
		processing = true
		paying_time = 0
	else:
		print("NO CUSTOMER IN LINE")


func _on_Actionable_action_released():
	if processing:
		print("PROCESS CUSTOMER IN LINE")
		processing = false


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):	
		$Actionable.player_in_area = true

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):	
		$Actionable.player_in_area = false
		if processing:
			print("player left cashier area")
			processing = false
