extends Node2D

const BASE_POSITION = 90
const STEP = 20

onready var animation_player = $AnimationPlayer
onready var coin_sprite = $CoinSprite
onready var balls = $"../Balls"

signal subtract_coin


func _on_Slider_value_changed(value):
	coin_sprite.position.x = BASE_POSITION + value * STEP
	

func _on_Slider_drag_ended(_value_changed):
	emit_signal("subtract_coin")
	yield(coin_sprite, "animation_finished")
	disable_slotter()
	balls.spawn_coin(coin_sprite.global_position)


func _on_TurnSystem_turn_ready():
	enable_slotter()


func _on_TurnSystem_game_over(_message, _first_loss):
	disable_slotter()


func enable_slotter():
	change_slotter_state(true)
	animation_player.play("Highlight")


func disable_slotter():
	change_slotter_state(false)
	animation_player.play("RESET")


func change_slotter_state(value):
	$Slider.editable = value
	coin_sprite.visible = value
