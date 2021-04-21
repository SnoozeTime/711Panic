extends Spatial

func _ready():
	MusicManager.play_menu()
	$Control/HBoxContainer/LevelSelector.button.grab_focus()


func start_game():
	MusicManager.play_sound(MusicManager.SoundType.ButtonClick)
	GameGlobals.tutorials_enabled = $Control/TutorialCheckbox.pressed
	if GameGlobals.tutorials_enabled:
		Transition.fade_to("res://Src/Tutorial/Tutorial1.tscn")
	else:
		Transition.fade_to("res://Game.tscn")

func _on_Level1_pressed():
	GameGlobals.select_level(1)
	start_game()

func _on_Level2_pressed():
	GameGlobals.select_level(2)
	start_game()

func _on_Level3_pressed():
	GameGlobals.select_level(3)
	start_game()

func _on_Level4_pressed():
	GameGlobals.select_level(4)
	start_game()

func _on_BackButton_pressed():
	MusicManager.play_sound(MusicManager.SoundType.ButtonClick)
	Transition.fade_to("res://Src/Screens/MainMenu.tscn")

func _on_Button_mouse_entered():
	MusicManager.play_sound(MusicManager.SoundType.ButtonHover)


func _on_TutorialCheckbox_pressed():
	MusicManager.play_sound(MusicManager.SoundType.CheckboxToggle)
