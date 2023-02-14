extends Node2D

const CoinBag = preload("res://board/power_ups/coin_bag.tscn")


func spawn_coin_bag(here):
	var bag = CoinBag.instance()
	bag.position = here
	call_deferred("add_child", bag)
