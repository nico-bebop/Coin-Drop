extends Node2D

const SinglePlayer = preload("res://board/turn_system/single_player.tscn")
const Versus = preload("res://board/turn_system/versus.tscn")

onready var coins = $Coins
onready var turn_system = $TurnSystem

signal board_ready


func _ready():
	set_game_mode()
	randomize()

	for switch in get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES):
		switch.set_random_position()
		yield(switch.get("animation_player"), "animation_finished")

	throw_random_coins()
	yield(coins, "no_moving_coins")
	emit_signal("board_ready")


func set_game_mode():
	match Globals.game_mode:
		Globals.GameModes.SINGLE_PLAYER:
			turn_system.current_system = SinglePlayer.instance()
		Globals.GameModes.VERSUS:
			turn_system.current_system = Versus.instance()
	turn_system.add_child(turn_system.current_system)


func throw_random_coins():
	var slots = get_tree().get_nodes_in_group(Globals.GROUP_SLOTS)
	slots.shuffle()
	for slot in slots.slice(0, slots.size(), 2):
		slot.spawn_coin()
		yield(get_tree().create_timer(0.2), "timeout")
