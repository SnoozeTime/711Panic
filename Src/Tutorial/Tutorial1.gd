extends Control


func select_tutorials():
	$MarginContainer/VBoxContainer/PickupTuto.hide()
	$MarginContainer/VBoxContainer/PlaceShelfTuto.hide()
	$MarginContainer/VBoxContainer/PayTuto.hide()
	$MarginContainer/VBoxContainer/BrokenTuto.hide()
	$MarginContainer/VBoxContainer/DashTuto.hide()
	$MarginContainer/VBoxContainer/IcecreamTuto.hide()
	$MarginContainer/VBoxContainer/EnvTuto.hide()
	
	match GameGlobals.selected_level:
		0:
			$MarginContainer/VBoxContainer/PickupTuto.show()
			$MarginContainer/VBoxContainer/PlaceShelfTuto.show()
			$MarginContainer/VBoxContainer/PayTuto.show()
		1:
			$MarginContainer/VBoxContainer/DashTuto.show()
			$MarginContainer/VBoxContainer/BrokenTuto.show()
		2:
			$MarginContainer/VBoxContainer/IcecreamTuto.show()
		3:
			$MarginContainer/VBoxContainer/EnvTuto.show()

# Called when the node enters the scene tree for the first time.
func _ready():
	select_tutorials()
	$ContinueButton.grab_focus()

func _on_ContinueButton_pressed():
	MusicManager.play_sound(MusicManager.SoundType.ButtonClick)
	Transition.fade_to("res://Game.tscn")


func _on_ContinueButton_focus_entered():
	MusicManager.play_sound(MusicManager.SoundType.ButtonHover)
