extends Node2D

signal no_moving_coins


func check_active_coins():
	for coin in get_children():
		if coin.is_moving:
			return
	emit_signal("no_moving_coins")
