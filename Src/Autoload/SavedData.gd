extends Node

var saved_data = {
	# Max scores
	"scores": [0,0,0,0]
}

# Set the score for the current level. If high score, will override the saved data
# and returns true.
func set_score(level, score) -> bool:
	saved_data["scores"][level] = max(saved_data["scores"][level], score)
	save_game()
	return saved_data["scores"][level] == score

# Get current high score
func get_score(level) -> int:
	return saved_data["scores"][level]


func save_game():
	var file = File.new()
	file.open("user://savegame.save", File.WRITE)
	
	var serialized = to_json(saved_data)
	file.store_line(serialized)
	file.close()
	
func load_game():
	var file = File.new()
	if not file.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	file.open("user://savegame.save", File.READ)
	saved_data = parse_json(file.get_line())
	
	var has_issue = false
	if saved_data is Dictionary:
		if saved_data.has("scores") and saved_data["scores"] is Array and saved_data["scores"].size() == 4:
			pass
		else:
			has_issue = true
	else:
		has_issue = true
		
	if has_issue:
		print("Issue while loading the data")
		saved_data = {
			# Max scores
			"scores": [0,0,0,0]
		}
	file.close()
