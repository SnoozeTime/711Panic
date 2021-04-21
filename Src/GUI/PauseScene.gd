extends Control

var is_paused = false

func _process(delta):
	if Input.is_action_just_pressed("Pause") && is_paused:
		resume()

func pause():
	$MarginContainer/VBoxContainer/ResumeButton.grab_focus()
	show()
	set_deferred("is_paused", true)

func _on_ResumeButton_pressed():
	resume()

func resume():
	get_tree().paused = false
	is_paused = false
	hide()

func _on_ExitButton_pressed():
	resume()
	Transition.fade_to("res://Src/Screens/MainMenu.tscn")
