extends Node2D

onready var animation_player = $AnimationPlayer

export(String) var orientation


func set_random_position():
	randomize()
	if randi() % 2 == 0:
		animation_player.play("FlipToLeft")
	else:
		animation_player.play("FlipToRight")


func flip_contrary():
	match orientation:
		Globals.LEFT:
			animation_player.play("FlipToRight")
		Globals.RIGHT:
			animation_player.play("FlipToLeft")


func _on_Bottom_body_entered(_body):
	flip_contrary()
