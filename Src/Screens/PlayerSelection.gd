extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play_menu()
	$MarginContainer/MarginContainer2/Button.grab_focus()

func _on_PrevSkin_pressed():
	MusicManager.play_sound(MusicManager.SoundType.CheckboxToggle)
	var new_id = ($Character.current_skin_idx - 1) % $Character.SKIN_PALETTE.size()
	if new_id == -1:
		new_id = $Character.SKIN_PALETTE.size() - 1
	$Character.set_skin_color(new_id)
	PlayerDefault.skin_color_idx = $Character.current_skin_idx

func _on_NextSkin_pressed():	
	MusicManager.play_sound(MusicManager.SoundType.CheckboxToggle)
	var new_id = ($Character.current_skin_idx + 1) % $Character.SKIN_PALETTE.size()
	$Character.set_skin_color(new_id)
	PlayerDefault.skin_color_idx = $Character.current_skin_idx


func _on_Button_pressed():
	MusicManager.play_sound(MusicManager.SoundType.ButtonClick)
	Transition.fade_to("res://Src/Screens/MainMenu.tscn")

func _on_HairColorPrev_pressed():
	MusicManager.play_sound(MusicManager.SoundType.CheckboxToggle)
	var new_id = ($Character.current_hair_idx - 1) % $Character.HAIR_PALETTE.size()
	if new_id == -1:
		new_id = $Character.HAIR_PALETTE.size() - 1
	$Character.set_hair_color(new_id)
	PlayerDefault.hair_color_idx = $Character.current_hair_idx


func _on_HairColorNext_pressed():
	MusicManager.play_sound(MusicManager.SoundType.CheckboxToggle)
	var new_id = ($Character.current_hair_idx + 1) % $Character.HAIR_PALETTE.size()
	$Character.set_hair_color(new_id)
	PlayerDefault.hair_color_idx = $Character.current_hair_idx


func _on_HairStylePrev_pressed():
	MusicManager.play_sound(MusicManager.SoundType.CheckboxToggle)
	var new_id = ($Character.current_hair_style_idx - 1) % $Character.hair_styles
	if new_id == -1:
		new_id = $Character.hair_styles
	$Character.set_hair(new_id)
	PlayerDefault.hair_style_idx = $Character.current_hair_style_idx


func _on_HairStyleNext_pressed():	
	MusicManager.play_sound(MusicManager.SoundType.CheckboxToggle)
	var new_id = ($Character.current_hair_style_idx + 1) % $Character.hair_styles
	$Character.set_hair(new_id)
	PlayerDefault.hair_style_idx = $Character.current_hair_style_idx


func _on_Button_mouse_entered():
	MusicManager.play_sound(MusicManager.SoundType.ButtonHover)
