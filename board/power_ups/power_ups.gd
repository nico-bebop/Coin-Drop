extends Node2D

const CoinBag = preload("res://board/power_ups/coin_bag.tscn")

const COIN_BAG_TURN = 7

var round_counter = 0


func spawn_coin_bag(here):
	var bag = CoinBag.instance()
	bag.position = here
	call_deferred("add_child", bag)


func spawn_random_coin_bag():
	var switches = get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES)
	switches.shuffle()
	for switch in switches:
		if !switch.has_ball:
			spawn_coin_bag(switch.coin_spawn_position.global_position + Vector2(0, 16))
			switch.has_ball = true
			return


func _on_TurnSystem_turn_ready():
	round_counter += 1
	if round_counter == COIN_BAG_TURN:
		spawn_random_coin_bag()
		round_counter = 0
