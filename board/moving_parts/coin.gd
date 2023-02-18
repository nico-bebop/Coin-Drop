extends "res://board/moving_parts/ball.gd"

const MAX_MULTIPLIER = 5

var can_shine = true
var multiplier = 1 setget set_multiplier

onready var animation_player = $AnimationPlayer
onready var shine_timer = $ShineTimer
onready var coin_combine_audio =  get_tree().current_scene.coin_combine_audio


func _physics_process(_delta):
	play_idle_animation()
	
	if ball_collision.is_colliding():
		var colliding_coin = ball_collision.get_collider()
		if colliding_coin.is_in_group(Globals.GROUP_COINS):
			combine_with(colliding_coin)


func play_idle_animation():
	if !is_moving && can_shine:
		shine_timer.start()
		animation_player.play("IdleShine")
		can_shine = false


func combine_with(colliding_coin):
	if is_moving && colliding_coin.is_moving:
		change_multiplier(multiplier + colliding_coin.multiplier)
		colliding_coin.queue_free()
		play_combine_effects()


func play_combine_effects():
	animation_player.play("HorizontalFlip")
	coin_combine_audio.play()
	$Sparkle.emitting = true


func change_multiplier(value):
	yield(animation_player, "animation_finished")
	multiplier = clamp(value, multiplier, MAX_MULTIPLIER)
	$Label.text = str(multiplier)


func set_multiplier(value):
	multiplier = value


func _on_ShineTimer_timeout():
	can_shine = true
