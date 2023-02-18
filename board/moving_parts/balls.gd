extends Node2D

const Coin = preload("res://board/moving_parts/coin.tscn")
const Bomb = preload("res://board/moving_parts/bomb.tscn")

signal no_moving_balls


func spawn_coin(here):
	var coin = Coin.instance()
	coin.position = here
	call_deferred("add_child", coin)


func spawn_bomb(here):
	var bomb = Bomb.instance()
	bomb.position = here
	call_deferred("add_child", bomb)


func check_active_balls():
	for ball in get_children():
		if ball.is_moving:
			return
	emit_signal("no_moving_balls")


func explode_bombs(_param):
	for bomb in get_children():
		if bomb.is_in_group(Globals.GROUP_BOMBS):
			bomb.explode()
			yield(get_tree().create_timer(0.2), "timeout")
