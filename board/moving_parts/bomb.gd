extends "res://board/moving_parts/ball.gd"

export(int) var ticks_left = 4

onready var label = $Label


func tick():
	ticks_left -= 1
	update_label()
	if ticks_left == 0:
		explode()


func explode():
	if(ticks_left == 0):
		queue_free()


func update_label():
	label.text = str(ticks_left)
