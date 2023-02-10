extends "res://board/moving_parts/ball.gd"

const MAX_MULTIPLIER = 5

var can_shine = true
var multiplier = 1 setget set_multiplier

onready var animation_player = $AnimationPlayer
onready var ball_collision = $BallCollision
onready var coin_combine_audio = $CoinCombineAudio
onready var label = $Label
onready var shine_timer = $ShineTimer
onready var sparkle_effect = $Sparkle


func _physics_process(_delta):
	play_idle_animation()


func play_idle_animation():
	if !is_moving && can_shine:
		shine_timer.start()
		animation_player.play("IdleShine")
		can_shine = false


func _on_BallCollision_body_entered(_body):
	._on_BallCollision_body_entered(_body)

	var coins = get_only_coins(ball_collision.get_overlapping_bodies())
	if coins.size() > 1:
		combine(coins)


func combine(coins):
	if coins[0].is_moving && coins[1].is_moving:
		play_combine_effects()
		change_multiplier(coins[0].multiplier + coins[1].multiplier)
		coins[0].queue_free()


func play_combine_effects():
	animation_player.stop()
	animation_player.play("HorizontalFlip")
	coin_combine_audio.play()
	sparkle_effect.emitting = true


func get_only_coins(bodies):
	var coins = []
	for body in bodies:
		if body.is_in_group(Globals.GROUP_COINS):
			coins.append(body)
	return coins


func change_multiplier(value):
	yield(animation_player, "animation_finished")
	multiplier = clamp(value, multiplier, MAX_MULTIPLIER)
	label.text = str(multiplier)


func set_multiplier(value):
	multiplier = value


func _on_ShineTimer_timeout():
	can_shine = true
