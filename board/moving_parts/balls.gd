extends Node2D

const Coin = preload("res://board/moving_parts/coin.tscn")
const Bomb = preload("res://board/moving_parts/bomb.tscn")
const Pop = preload("res://assets/effects/pop.tscn")

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
	for ball in get_tree().get_nodes_in_group(Globals.GROUP_BALLS):
		if ball.is_moving || ball.is_exploding:
			return
	emit_signal("no_moving_balls")


func explode_bombs():
	for bomb in get_tree().get_nodes_in_group(Globals.GROUP_BOMBS):
		if is_instance_valid(bomb):
			bomb.explode()
			yield(get_tree().create_timer(0.2), "timeout")


func explode_coin(here):
	var explosion = Pop.instance()
	explosion.position = here
	call_deferred("add_child", explosion)


func explode_coins():
	for coin in get_tree().get_nodes_in_group(Globals.GROUP_COINS):
		if is_instance_valid(coin):
			explode_coin(coin.global_position)
			coin.queue_free()
			yield(get_tree().create_timer(0.2), "timeout")


func _on_TurnSystem_game_over(_message, first_loss):
	if !first_loss:
		explode_coins()
		explode_bombs()


func _on_TurnSystem_round_ended(_current_round):
	explode_bombs()
