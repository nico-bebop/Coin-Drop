extends Area2D

var slot_score = 0 setget set_score
var current_player
var current_round

export(Array, int) var score_array = [0, 0, 0, 0]

onready var label = $Label
onready var coin_score_audio = $CoinScoreAudio
onready var confetti_effect = $Confetti

signal add_score(player, current, value)


func _ready():
	var _err
	_err = connect("add_score", get_node("../../UserInterface/PlayerScore1"), "update_score")
	_err = connect("add_score", get_node("../../UserInterface/PlayerScore2"), "update_score")
	set_score(score_array[0])


func _on_ScoreSlot_body_entered(body):
	current_player = get_tree().current_scene.current_turn
	current_round = get_tree().current_scene.current_round
	emit_signal("add_score", current_player, current_round, slot_score * body.get("multiplier"))
	coin_score_audio.play()
	confetti_effect.emitting = true
	body.queue_free()


func set_score(value):
	slot_score = value
	label.text = str(value)
