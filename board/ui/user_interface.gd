extends Control

onready var animation_player = $AnimationPlayer


func _ready():
	animation_player.play("SignAppear")
	yield(animation_player, "animation_finished")


func _on_PauseButton_pressed():
	get_tree().paused = true


func _on_RestartButton_pressed():
	var _err = get_parent().get_tree().reload_current_scene()
