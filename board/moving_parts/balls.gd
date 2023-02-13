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


func _on_TurnSystem_turn_ready():
	var bombs = get_tree().get_nodes_in_group(Globals.GROUP_BOMBS)
	for bomb in bombs:
		bomb.tick()
		if bomb.ticks_left == 0:
			bomb.explode()
