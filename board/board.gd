extends Node2D

const GameOver = preload("res://board/ui/game_over.tscn")

onready var coins = $Coins

signal board_ready


func _ready():
	randomize()
	for switch in get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES):
		switch.set_random_position()
		yield(switch.get("animation_player"), "animation_finished")
	
	throw_random_coins()
	yield(coins, "no_moving_coins")
	emit_signal("board_ready")


func throw_random_coins():
	var slots = get_tree().get_nodes_in_group(Globals.GROUP_SLOTS)
	slots.shuffle()
	for slot in slots.slice(0, slots.size(), 2):
		slot.spawn_coin()
		yield(get_tree().create_timer(0.2), "timeout")


func _on_TurnSystem_game_over(players):
	var game_over = GameOver.instance()
	add_child(game_over)
	game_over.check_winner(players[0], players[1])
	game_over.popup_centered()
