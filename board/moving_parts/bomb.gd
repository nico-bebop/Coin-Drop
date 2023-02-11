extends "res://board/moving_parts/ball.gd"

enum { EXPLODE, RED_GLOW, HALF_TIME, IGNITED }

export(int) var ticks_left = 3
export(bool) var ignited = false

onready var label = $Label
onready var spark = $Spark
onready var animation_player = $AnimationPlayer
onready var switch_collision = $SwitchCollision


func _ready():
	update_label()


func tick():
	if ignited:
		ticks_left -= 1

	update_label()
	update_animation()

	if ticks_left == 0:
		explode()


func update_label():
	label.text = str(ticks_left)


func update_animation():
	match ticks_left:
		IGNITED:
			animation_player.play("Ignited")
		HALF_TIME:
			animation_player.play("HalfTime")
		RED_GLOW:
			animation_player.play("RedGlow")
		EXPLODE:
			animation_player.play("Blink")
		_:
			animation_player.play("RESET")


func explode():
	yield(animation_player, "animation_finished")
	get_colliding_switch().destroy_switch()
	queue_free()


func get_colliding_switch():
	for body in switch_collision.get_overlapping_bodies():
		if body.is_in_group(Globals.GROUP_SWITCHES):
			return body
