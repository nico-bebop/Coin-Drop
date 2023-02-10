extends Node2D

signal no_moving_balls


func check_active_balls():
	for ball in get_children():
		if ball.is_moving:
			return
	emit_signal("no_moving_balls")
