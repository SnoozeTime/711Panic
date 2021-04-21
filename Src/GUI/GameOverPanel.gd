extends Control

var gold_medal = preload("res://Assets/2d/goldmedal.png")
var silver_medal = preload("res://Assets/2d/silvermedal.png")
var bronze_medal = preload("res://Assets/2d/bronzemedal.png")
onready var medal_container = $Panel/MarginContainer/VBoxContainer/HBoxContainer2/Medal


func show_game_over(score):
	
	if GameGlobals.is_last_level():
		$Panel/MarginContainer/VBoxContainer/HBoxContainer/NextLevelButton.hide()
		$Panel/MarginContainer/VBoxContainer/HBoxContainer/RetryButton.grab_focus()
	else:
		$Panel/MarginContainer/VBoxContainer/HBoxContainer/NextLevelButton.grab_focus()
	var best_score = SavedData.get_score(GameGlobals.selected_level)
	var is_best = best_score == score
	
	$Panel/MarginContainer/VBoxContainer/HBoxContainer3/BestScoreLabel.text = "Best score: %s" % best_score
	if is_best:
		$Panel/MarginContainer/VBoxContainer/HBoxContainer3/NextRecordLabel.show()
	else:
		$Panel/MarginContainer/VBoxContainer/HBoxContainer3/NextRecordLabel.hide()
	
	show()
	MusicManager.play_sound(MusicManager.SoundType.Victory)
	
	$Panel/MarginContainer/VBoxContainer/HBoxContainer2/ScoreLabel.text = "You scored %s!" % score
	
	match GameGlobals.get_medal(GameGlobals.selected_level, score):
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


func _on_NextLevelButton_pressed():
	GameGlobals.selected_level += 1
	if GameGlobals.tutorials_enabled:
		Transition.fade_to("res://Src/Tutorial/Tutorial1.tscn")
	else:
		Transition.fade_to("res://Game.tscn")


func _on_ReturnToMenuButton_pressed():
	Transition.fade_to("res://Src/Screens/LevelSelection.tscn")


func _on_RetryButton_pressed():
	Transition.fade_to("res://Game.tscn")
