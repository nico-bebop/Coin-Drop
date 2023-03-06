extends Node2D

const FloatingText = preload("res://assets/effects/floating_text.tscn")


func instance_floating_text(text, here):
	var floating_text = FloatingText.instance()
	floating_text.position = here
	floating_text.text = text
	call_deferred("add_child", floating_text)
