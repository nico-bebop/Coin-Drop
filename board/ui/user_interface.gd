extends Control

const PauseButton = preload("res://assets/sprites/ui/in_game_buttons/pause_button.png")
const ResumeButton = preload("res://assets/sprites/ui/in_game_buttons/resume_button.png")
const RestartButton = preload("res://assets/sprites/ui/in_game_buttons/restart_button.png")

const TITLE = "Coin\nDrop"
const PAUSED = "Paused"
const RESTART = "Restart?"

onready var animation_player = $AnimationPlayer
onready var sign_label = $Sign/Label
onready var pause_button = $PauseButton
onready var accept_button = $AcceptButton
onready var cancel_button = $CancelButton
onready var quit_button = $QuitButton


func _ready():
	animation_player.play("SignAppear")
	yield(animation_player, "animation_finished")


func _on_PauseButton_pressed():
	if !get_tree().paused:
		pause(true, PAUSED, ResumeButton)
	else:
		pause(false, TITLE, PauseButton)


func _on_RestartButton_pressed():
	restart(true, RESTART)


func _on_CancelButton_pressed():
	restart(false, TITLE)


func _on_AcceptButton_pressed():
	var _err = get_parent().get_tree().reload_current_scene()


func _on_QuitButton_pressed():
	get_tree().paused = false
	var _err = get_tree().change_scene("res://menu/main_menu.tscn")


func pause(value, text, texture):
	sign_label.text = text
	pause_button.texture_normal = texture
	quit_button.visible = value
	get_tree().paused = value


func restart(value, text):
	sign_label.text = text
	pause_button.disabled = value
	accept_button.visible = value
	cancel_button.visible = value
