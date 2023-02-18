extends Node2D

const CoinBag = preload("res://board/power_ups/coin_bag.tscn")
const ExtraCoins = preload("res://board/power_ups/extra_coins.tscn")
const Pop = preload("res://assets/effects/pop.tscn")

const COIN_BAG_TURN = 9
const EXTRA_COINS_TURN = 5

var bag_counter = 0
var extra_counter = 0


func instance_power_up(power_up, here):
	var power = power_up.instance()
	power.position = here
	call_deferred("add_child", power)


func spawn_power_up(power_up):
	var switches = get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES)
	switches.shuffle()
	for switch in switches:
		if !switch.has_ball:
			instance_power_up(power_up, switch.coin_spawn_position.global_position + Vector2(0, 16))
			switch.has_ball = true
			return


func explode_power_up(here):
	var explosion = Pop.instance()
	explosion.position = here
	call_deferred("add_child", explosion)


func explode_power_ups(_param):
	for power in get_tree().get_nodes_in_group(Globals.GROUP_POWER_UPS):
		if is_instance_valid(power):
			explode_power_up(power.global_position)
			power.queue_free()
			yield(get_tree().create_timer(0.2), "timeout")


func _on_TurnSystem_turn_ready():
	bag_counter += 1
	if bag_counter == COIN_BAG_TURN:
		spawn_power_up(CoinBag)
		bag_counter = 0

	if Globals.game_mode == Globals.GameModes.SINGLE_PLAYER:
		extra_counter += 1
		if extra_counter == EXTRA_COINS_TURN:
			spawn_power_up(ExtraCoins)
			extra_counter = 0
