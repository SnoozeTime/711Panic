extends Node



onready var levels = [
	$Level1,
	$Level2,
	$Level3,
	$Level4,
]

enum SoundType {
	ButtonHover,
	ButtonClick,
	CheckboxToggle,
	PlaceItem,
	Pay,
	Dash,
	Victory,
	Angry,
	Obasan,
	Random,
	Break,
	Repare
}

onready var sounds = {
	SoundType.ButtonHover: $InterfaceEffects/ButtonHover,
	SoundType.ButtonClick: $InterfaceEffects/ButtonClick,
	SoundType.CheckboxToggle: $InterfaceEffects/CheckboxToggle,
	SoundType.PlaceItem: $InterfaceEffects/Item,
	SoundType.Pay: $InterfaceEffects/Pay,
	SoundType.Dash: $InterfaceEffects/Dash,
	SoundType.Victory: $InterfaceEffects/Victory,
	SoundType.Angry: $InterfaceEffects/Angry,
	SoundType.Obasan: $InterfaceEffects/Obasan,
	SoundType.Random: $InterfaceEffects/Random,
	SoundType.Break: $InterfaceEffects/Break,
	SoundType.Repare: $InterfaceEffects/Repare,
}

onready var volumes = {
	"Master": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
	"Background": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Background")),
	"Sound": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound")),
}

func _ready():
	pass
	AudioServer.get_bus_volume_db(0)

func play_menu():
	
	for lvl in levels:
		if lvl.playing:
			lvl.stop()
	
	if not $Background.playing:
		$Background.play()
	
func play_level():
	for lvl in levels:
		if lvl.playing:
			lvl.stop()
	
	if $Background.playing:
		$Background.stop()
		
	levels[GameGlobals.selected_level].play()

func play_sound(sound_name):
	if sounds.has(sound_name) and not sounds[sound_name].playing:
		sounds[sound_name].play()


