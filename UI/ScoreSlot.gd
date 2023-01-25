extends Area2D

var slot_score = 0 setget set_score

onready var label = $Label

signal add_score(value)


func _on_ScoreSlot_body_entered(body):
	body.queue_free()
	emit_signal("add_score", slot_score * body.get("multiplier"))


func set_score(value):
	slot_score = value
	label.text = str(value)
