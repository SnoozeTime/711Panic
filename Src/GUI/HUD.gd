extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerLabel.hide()

func update_game_timer(minutes, seconds):
	$TimerLabel.text = "%s:%s" % [minutes, seconds]

func set_message(msg):
	$MessageLabel.text = msg

func update_points(pts):
	$MoneyLabel.text = "¥%s" % pts

func clear_customers():
	$CustomerGUI.clear()
