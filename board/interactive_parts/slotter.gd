extends Node2D

const BASE_POSITION = 90
const STEP = 20

onready var animation_player = $AnimationPlayer
onready var coin_sprite = $CoinSprite
onready var tween = $Tween
onready var balls = $"../Balls"

signal subtract_coin


func _ready():
	tween.interpolate_property($Slider, "value", 1, 8, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.5)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property($Slider, "value", 8, 1, 1.5)
	tween.start()


func _on_Slider_value_changed(value):
	coin_sprite.position.x = BASE_POSITION + value * STEP
	

func _on_Slider_drag_ended(_value_changed):
	if coin_sprite.visible:
		emit_signal("subtract_coin")
		yield(coin_sprite, "animation_finished")
		disable_slotter()
		balls.spawn_coin(coin_sprite.global_position)


func _on_TurnSystem_turn_ready():
	enable_slotter()


func _on_TurnSystem_game_over(_message, _first_loss):
	$Slider.editable = false
	disable_slotter()


func enable_slotter():
	coin_sprite.visible = true
	animation_player.play("Highlight")


func disable_slotter():
	coin_sprite.visible = false
	animation_player.play("RESET")
