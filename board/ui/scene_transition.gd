extends CanvasLayer

onready var animation_player = $AnimationPlayer
onready var music_intro = $MusicIntro
onready var music_loop = $MusicLoop
onready var tween = $Tween


func _ready():
	animation_player.play("SplashLogo")
	yield(animation_player, "animation_finished")
	play_music()

func change_scene(target):
	animation_player.play("Disolve")
	yield(animation_player, "animation_finished")
	var _err = get_tree().change_scene(target)
	animation_player.play_backwards("Disolve")


func restart_scene():
	animation_player.play("Disolve")
	yield(animation_player, "animation_finished")
	var _err = get_parent().get_tree().reload_current_scene()
	animation_player.play_backwards("Disolve")


func play_music():
	music_intro.play()


func _on_MusicIntro_finished():
	music_loop.play()


func lower_music_volume():
	var current_volume = Settings.music_volume
	tween.interpolate_method(self, "change_music_volume", current_volume, -30.0, 1.0)
	tween.start()
	tween.interpolate_method(self, "change_music_volume", -30.0, current_volume, 2.0, Tween.TRANS_BACK, Tween.EASE_IN, 3.0)
	tween.start()


func change_music_volume(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
