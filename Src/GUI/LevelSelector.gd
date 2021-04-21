extends Panel

signal start_game()

onready var medal_container = $CenterContainer/VBoxContainer/Medal
onready var button = $CenterContainer/VBoxContainer/Button

var gold_medal = preload("res://Assets/2d/goldmedal.png")
var silver_medal = preload("res://Assets/2d/silvermedal.png")
var bronze_medal = preload("res://Assets/2d/bronzemedal.png")

export var level_number = 1

func _ready():
	$CenterContainer/VBoxContainer/Button.text = "%s" % level_number
	
	var score = SavedData.get_score(level_number-1)
	match GameGlobals.get_medal(level_number-1, score):
		"gold":
			medal_container.show()
			medal_container.texture = gold_medal
		"silver":
			medal_container.show()
			medal_container.texture = silver_medal
		"bronze":
			medal_container.show()
			medal_container.texture = bronze_medal
		_:
			medal_container.hide()
			
	$CenterContainer/VBoxContainer/ScoreLabel.text = "Best score: %s" % score


func _on_Button_pressed():
	emit_signal("start_game")


func _on_LevelSelector_focus_entered():
	MusicManager.play_sound(MusicManager.SoundType.ButtonHover)
