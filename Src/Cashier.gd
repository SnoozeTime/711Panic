extends Spatial

signal paid()

export var time_to_pay = 2.0 # seconds
var paying_time = 0
export var queue_path := NodePath()
onready var queue: Queue = get_node(queue_path)

var processing = false

func _process(delta):
	if processing:
		paying_time += delta
		$ProgressBar3D.set_progress(paying_time, time_to_pay)

		if paying_time > time_to_pay:
			pay()
			
			
func pay():
	
	MusicManager.play_sound(MusicManager.SoundType.Pay)
	paying_time = 0
	# Get the customer and make hime leave.
	queue.process_first_customer()
	$ProgressBar3D.hide_progress_bar()
	processing = false
	emit_signal("paid")


func _on_Actionable_action_from_player(_player):
	if queue.is_customer_waiting():

		processing = true
		queue.reset_first_customer_patience()
		paying_time = 0
		$ProgressBar3D.show_progress_bar()
		$ProgressBar3D.set_progress(paying_time, time_to_pay)


func _on_Actionable_action_released():
	if processing:
		processing = false
		$ProgressBar3D.hide_progress_bar()


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):	
		$Actionable.player_in_area = true

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):	
		$Actionable.player_in_area = false
		if processing:
			processing = false
			$ProgressBar3D.hide_progress_bar()

