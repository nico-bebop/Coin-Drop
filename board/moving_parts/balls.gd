extends Node2D

signal no_moving_balls


func check_active_balls():
	for ball in get_children():
		if ball.is_moving:
			return
	emit_signal("no_moving_balls")


func _on_TurnSystem_turn_ready():
	var bombs = get_tree().get_nodes_in_group(Globals.GROUP_BOMBS)
	for bomb in bombs:
		bomb.tick()
		if bomb.ticks_left == 0:
			bomb.explode()
