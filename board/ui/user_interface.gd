extends Control

const PauseButton = preload("res://assets/sprites/ui/pause_button.png")
const ResumeButton = preload("res://assets/sprites/ui/resume_button.png")
const RestartButton = preload("res://assets/sprites/ui/restart_button.png")

const TITLE = ["Coin", "Drop"]
const PAUSED = ["Paused", ""]
const RESTART = ["Restart?", ""]

onready var animation_player = $AnimationPlayer
onready var line1 = $Sign/Line1
onready var line2 = $Sign/Line2

onready var pause_button = $PauseButton
onready var restart_button = $RestartButton
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


func _on_TurnSystem_game_over(message):
	set_sign_text(message)
	pause_button.disabled = true
	accept_button.visible = false
	cancel_button.visible = false


func pause(value, message, texture):
	set_sign_text(message)
	pause_button.texture_normal = texture
	quit_button.visible = value
	get_tree().paused = value


func restart(value, message):
	set_sign_text(message)
	pause_button.disabled = value
	accept_button.visible = value
	cancel_button.visible = value


func set_sign_text(text):
	line1.text = text[0]
	line2.text = text[1]
