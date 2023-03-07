class_name SaveSystem
extends Reference

const SAVE_GAME_PATH := "user://save.json"

var version := 1
var settings: Resource = Settings.new()
var _file := File.new()


func save_exists():
	return _file.file_exists(SAVE_GAME_PATH)


func write_savegame():
	var error := _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return

	var data := {
		"version": version,
		"settings":
		{
			"sound_volume": settings.sound_volume,
			"music_volume": settings.music_volume,
			"sound_muted": settings.sound_muted,
			"music_muted": settings.music_muted,
			"user_authenticated": settings.user_authenticated,
		},
	}
	
	var json_string := JSON.print(data)
	_file.store_string(json_string)
	_file.close()


func load_savegame():
	var error := _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return

	var content := _file.get_as_text()
	_file.close()

	var data: Dictionary = JSON.parse(content).result
	
	if !data.has("version") || data.version != version:
		write_savegame() 
		load_savegame()

	settings = Settings.new()
	settings.sound_volume = data.settings.sound_volume
	settings.music_volume = data.settings.music_volume
	settings.sound_muted = data.settings.sound_muted
	settings.music_muted = data.settings.music_muted
	settings.user_authenticated = data.settings.user_authenticated
