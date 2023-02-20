extends Control

const PauseButton = preload("res://assets/sprites/ui/pause_button.png")
const ResumeButton = preload("res://assets/sprites/ui/resume_button.png")
const RestartButton = preload("res://assets/sprites/ui/restart_button.png")
const SingleSign = preload("res://assets/sprites/ui/sign.png")
const DoubleSign = preload("res://assets/sprites/ui/double_sign.png")

const TITLE = ["Coin", "Drop"]
const PAUSED = ["Paused", ""]
const RESTART = ["Restart?", ""]

onready var accept_button = $Buttons/AcceptButton
onready var cancel_button = $Buttons/CancelButton
onready var button_click_audio = $Buttons/ButtonClickAudio


func _ready():
	$AnimationPlayer.play("SignAppear")
	yield($AnimationPlayer, "animation_finished")


func _on_PauseButton_pressed():
	button_click_audio.play()
	if !get_tree().paused:
		$Sign.texture = DoubleSign
		$Buttons/PauseButton.texture_normal = ResumeButton
		pause(true, PAUSED)
	else:
		$Sign.texture = SingleSign
		$Buttons/PauseButton.texture_normal = PauseButton
		pause(false, TITLE)


func _on_RestartButton_pressed():
	button_click_audio.play()
	restart(true, RESTART)


func _on_CancelButton_pressed():
	button_click_audio.play()
	restart(false, TITLE)


func _on_AcceptButton_pressed():
	button_click_audio.play()
	SceneTransition.restart_scene()


func _on_QuitButton_pressed():
	button_click_audio.play()
	get_tree().paused = false
	SceneTransition.change_scene("res://menu/main_menu.tscn")


func _on_TurnSystem_game_over(message):
	set_sign_text(message)
	$Buttons/RestartButton/AnimatedSprite.play()
	accept_button.visible = false
	cancel_button.visible = false


func pause(value, message):
	set_sign_text(message)
	get_tree().paused = value
	$Buttons/QuitButton.visible = value
	$Sign/VolumeControls.visible = value
	accept_button.visible = false
	cancel_button.visible = false


func restart(value, message):
	set_sign_text(message)
	accept_button.visible = value
	cancel_button.visible = value


func set_sign_text(text):
	$Sign/Line1.text = text[0]
	$Sign/Line2.text = text[1]
