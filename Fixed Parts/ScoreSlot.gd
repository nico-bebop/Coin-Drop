extends Area2D

var slot_score = 0 setget set_score

export(Array, int) var score_array = [0, 0, 0, 0]

onready var label = $Label
onready var coin_score_audio = $CoinScoreAudio
onready var confetti_effect = $Confetti

signal add_score(value)


func _ready():
	set_score(score_array[0])


func _on_ScoreSlot_body_entered(body):
	emit_signal("add_score", slot_score * body.get("multiplier"))
	coin_score_audio.play()
	confetti_effect.emitting = true
	body.queue_free()


func set_score(value):
	slot_score = value
	label.text = str(value)
