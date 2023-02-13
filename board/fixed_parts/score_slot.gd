extends Area2D

const BrokenSlot = preload("res://board/broken_parts/broken_slot.tscn")

var current_player
var current_round
var slot_score = 0 setget set_score

export(Array, int) var scores = [0, 0, 0, 0]

onready var animation_player = $AnimationPlayer
onready var label = $Label
onready var coin_miss_audio = $CoinMissAudio
onready var coin_score_audio = $CoinScoreAudio
onready var confetti_effect = $Confetti
onready var holes = $"../../Holes"

signal ball_exited
signal coin_scored(score)


func _ready():
	var _err = connect("ball_exited", get_parent(), "ball_entered_slot")
	_err = connect("coin_scored", get_parent(), "coin_entered_slot")


func _on_ScoreSlot_body_entered(ball):
	if ball.is_in_group(Globals.GROUP_COINS):
		if slot_score != 0:
			emit_signal("coin_scored", slot_score * ball.get("multiplier"))
			coin_score_audio.play()
			confetti_effect.emitting = true
		else:
			coin_miss_audio.play()
		ball.free()

	elif ball.is_in_group(Globals.GROUP_BOMBS):
		ball.explode()
		yield(ball.animation_player, "animation_finished")
		destroy_slot()

	emit_signal("ball_exited")


func destroy_slot():
	add_hole()
	label.text = ""
	slot_score = 0
	scores = [0, 0, 0, 0]


func add_hole():
	var hole = BrokenSlot.instance()
	hole.global_position = global_position
	holes.add_child(hole)


func set_score(value):
	slot_score = value
	label.text = str(slot_score) if slot_score != 0 else ""
