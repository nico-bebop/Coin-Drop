extends Area2D

var current_player
var current_round
var slot_score = 0 setget set_score

export(Array, int) var scores = [0, 0, 0, 0]

onready var animation_player = $AnimationPlayer
onready var label = $Label
onready var coin_score_audio = $CoinScoreAudio
onready var confetti_effect = $Confetti

signal coin_scored(score)


func _on_ScoreSlot_body_entered(ball):
	if ball.is_in_group(Globals.GROUP_COINS):
		emit_signal("coin_scored", slot_score * ball.get("multiplier"))
		coin_score_audio.play()
		confetti_effect.emitting = true
	elif ball.is_in_group(Globals.GROUP_BOMBS):
		destroy_slot()

	ball.queue_free()


func set_score(value):
	slot_score = value
	label.text = str(slot_score)


func destroy_slot():
	#play explode animation
	queue_free()
