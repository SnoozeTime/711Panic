extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SavedData.load_game()
	MusicManager.play_menu()
	$Control/MarginContainer/VBoxContainer/StartButton.grab_focus()


func _on_StartButton_pressed():
	MusicManager.play_sound(MusicManager.SoundType.ButtonClick)
	Transition.fade_to("res://Src/Screens/LevelSelection.tscn")


func _on_CharacterSelectionButton_pressed():
	MusicManager.play_sound(MusicManager.SoundType.ButtonClick)
	Transition.fade_to("res://Src/Screens/PlayerSelection.tscn")


func _on_ControlsButton_pressed():
	MusicManager.play_sound(MusicManager.SoundType.ButtonClick)
	Transition.fade_to("res://Src/Screens/ControlsScreen.tscn")


func _on_Button_mouse_entered():
	MusicManager.play_sound(MusicManager.SoundType.ButtonHover)


func _on_HSlider_value_changed(value):
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Sound"), false)
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Sound"), 
			MusicManager.volumes["Sound"] - 2*(100-value)/10.0
		)


func _on_HSlider2_value_changed(value):
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Background"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Background"), false)
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Background"), 
			MusicManager.volumes["Background"] - 2*(100-value)/10.0
		)
