extends Control

const PauseButton = preload("res://assets/sprites/ui/pause_button.png")
const ResumeButton = preload("res://assets/sprites/ui/resume_button.png")
const RestartButton = preload("res://assets/sprites/ui/restart_button.png")
const SingleSign = preload("res://assets/sprites/ui/sign.png")
const DoubleSign = preload("res://assets/sprites/ui/double_sign.png")

const TITLE = ["Coin", "Drop"]
const PAUSED = ["Paused", ""]
const RESTART = ["Restart?", ""]

var ad_viewed = false

onready var accept_button = $Buttons/AcceptButton
onready var cancel_button = $Buttons/CancelButton
onready var button_click_audio = $Buttons/ButtonClickAudio
onready var restart_animation = $Buttons/RestartButton/AnimatedSprite
onready var ad_mob = $"../AdMob"


func _ready():
	$AnimationPlayer.play("SignAppear")
	yield($AnimationPlayer, "animation_finished")
	$Sign/VolumeControls.load_music_options()
	ad_mob.load_interstitial()


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
	if !ad_viewed:
		ad_mob.show_interstitial()
	SceneTransition.restart_scene()


func _on_QuitButton_pressed():
	button_click_audio.play()
	get_tree().paused = false
	SceneTransition.change_scene("res://menu/main_menu.tscn")


func _on_TurnSystem_game_over(message, first_loss):
	set_sign_text(message)
	restart_animation.play()
	accept_button.visible = false
	cancel_button.visible = false
	if ad_mob.init():
		show_ad(first_loss)


func pause(value, message):
	set_sign_text(message)
	get_tree().paused = value
	$Buttons/QuitButton.visible = value
	$Sign/VolumeControls.visible = value
	$Sign/AdControl.visible = false
	accept_button.visible = false
	cancel_button.visible = false


func restart(value, message):
	set_sign_text(message)
	accept_button.visible = value
	cancel_button.visible = value


func set_sign_text(text):
	$Sign/Line1.text = text[0]
	$Sign/Line2.text = text[1]


func show_ad(first_loss):
	if first_loss:
		$Sign.texture = DoubleSign
		$Sign/AdControl.visible = true
		ad_mob.load_rewarded_video()

	if Globals.game_mode == Globals.GameModes.VERSUS:
		yield(get_tree().create_timer(2.0), "timeout")
		ad_mob.show_interstitial()
		ad_viewed = true


func _on_WatchAdButton_pressed():
	button_click_audio.play()
	ad_mob.show_rewarded_video()


func _on_AdMob_rewarded(_currency, _amount):
	$Sign.texture = SingleSign
	$Sign/AdControl.visible = false
	set_sign_text(TITLE)
	restart_animation.stop()
	ad_viewed = true
