extends Control

const SoundOn = preload("res://assets/sprites/ui/sound_on.png")
const SoundOff = preload("res://assets/sprites/ui/sound_off.png")
const MusicOn = preload("res://assets/sprites/ui/music_on.png")
const MusicOff = preload("res://assets/sprites/ui/music_off.png")

onready var mute_sound = $MuteSound
onready var mute_music = $MuteMusic
onready var sound_volume_slider = $SoundVolumeSlider
onready var music_volume_slider = $MusicVolumeSlider
onready var button_click_audio = $ButtonClickAudio

var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")


func load_music_options():
	var settings = SaveController.get_settings()
	sound_volume_slider.value = settings.sound_volume
	music_volume_slider.value = settings.music_volume

	if settings.sound_muted:
		mute_sound.texture_normal = SoundOff
		mute_sound.pressed = true
	if settings.music_muted:
		mute_music.texture_normal = MusicOff
		mute_music.pressed = true


func save_music_options():
	var settings = Settings.new()
	settings.sound_volume = sound_volume_slider.value
	settings.music_volume = music_volume_slider.value
	settings.sound_muted = mute_sound.pressed
	settings.music_muted = mute_music.pressed
	SaveController.save_sound_settings(settings)


func _on_MuteSound_toggled(button_pressed):
	if button_pressed:
		mute_sound.texture_normal = SoundOff
		AudioServer.set_bus_mute(master_bus, true)
		sound_volume_slider.editable = false
	else:
		mute_sound.texture_normal = SoundOn
		AudioServer.set_bus_mute(master_bus, false)
		sound_volume_slider.editable = true


func _on_MuteMusic_toggled(button_pressed):
	if button_pressed:
		mute_music.texture_normal = MusicOff
		AudioServer.set_bus_mute(music_bus, true)
		music_volume_slider.editable = false
	else:
		mute_music.texture_normal = MusicOn
		AudioServer.set_bus_mute(music_bus, false)
		music_volume_slider.editable = true


func _on_SoundVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	mute_bus_at_minimum(master_bus, value)
	if visible:
		button_click_audio.play()


func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)
	mute_bus_at_minimum(music_bus, value)


func mute_bus_at_minimum(bus, value):
	if value == -30:
		AudioServer.set_bus_mute(bus, true)
	else:
		AudioServer.set_bus_mute(bus, false)
