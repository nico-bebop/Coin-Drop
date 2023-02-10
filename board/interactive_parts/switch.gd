extends Node2D

const FLIP_TO_LEFT = "FlipToLeft"
const FLIP_TO_RIGHT = "FlipToRight"

onready var animation_player = $AnimationPlayer

export(String) var orientation


func set_random_position():
	if randi() % 2 == 0:
		animation_player.play(FLIP_TO_LEFT)
	else:
		animation_player.play(FLIP_TO_RIGHT)
	animation_player.seek(0.2)


func flip_contrary():
	match orientation:
		Globals.LEFT:
			animation_player.play(FLIP_TO_RIGHT)
		Globals.RIGHT:
			animation_player.play(FLIP_TO_LEFT)


func destroy_switch():
	#play explode animation
	queue_free()


func _on_Bottom_body_entered(_body):
	flip_contrary()
