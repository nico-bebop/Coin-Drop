extends CanvasLayer

onready var animation_player = $AnimationPlayer


func _ready():
	animation_player.play("SplashLogo")


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
