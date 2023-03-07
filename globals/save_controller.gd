extends Node

var _save := SaveSystem.new()


func _ready():
	_create_or_load_save()


func _create_or_load_save():
	if _save.save_exists():
		_save.load_savegame()
	else:
		_save.write_savegame()


func get_settings():
	return _save.settings


func save_sound_settings(settings):
	_save.settings.sound_volume = settings.sound_volume
	_save.settings.music_volume = settings.music_volume
	_save.settings.sound_muted = settings.sound_muted
	_save.settings.music_muted = settings.music_muted
	_save.write_savegame()


func save_login_info(value):
	_save.settings.user_authenticated = value
	_save.write_savegame()
