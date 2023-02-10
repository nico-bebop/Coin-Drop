extends "res://board/moving_parts/ball.gd"

export(int) var ticks_left = 4

onready var label = $Label
onready var switch_collision = $SwitchCollision


func tick():
	ticks_left -= 1
	update_label()
	if ticks_left == 0:
		explode()


func update_label():
	label.text = str(ticks_left)


func explode():
	get_colliding_switch().destroy_switch()
	queue_free()


func get_colliding_switch():
	for body in switch_collision.get_overlapping_bodies():
		if body.is_in_group(Globals.GROUP_SWITCHES):
			return body
