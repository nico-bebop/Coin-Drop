extends Area2D

var current_player
var current_round
var slot_score = 0 setget set_score

export(Array, int) var scores = [0, 0, 0, 0]

onready var animation_player = $AnimationPlayer
onready var label = $Label
onready var coin_score_audio = $CoinScoreAudio
onready var confetti_effect = $Confetti
onready var player1 = $"../../TurnSystem/Player1"
onready var player2 = $"../../TurnSystem/Player2"

signal add_score(value)


func _ready():
	var _err
	_err = connect("add_score", player1, "update_score")
	_err = connect("add_score", player2, "update_score")
	set_score(scores[0])


func _on_ScoreSlot_body_entered(coin):
	emit_signal("add_score", slot_score * coin.get("multiplier"))
	coin_score_audio.play()
	confetti_effect.emitting = true
	coin.queue_free()


func set_score(value):
	slot_score = value
	label.text = str(slot_score)
