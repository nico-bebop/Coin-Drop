extends Node2D

const SinglePlayer = preload("res://board/turn_system/single_player.tscn")
const Versus = preload("res://board/turn_system/versus.tscn")

const INITIAL_COINS = 10

onready var balls = $Balls
onready var power_ups = $PowerUps
onready var turn_system = $TurnSystem

signal board_ready


func _ready():
	set_game_mode()
	randomize()

	for switch in get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES):
		switch.set_random_position()
		yield(switch.get("animation_player"), "animation_finished")

	spawn_random_coins()
	yield(balls, "no_moving_balls")
	emit_signal("board_ready")


func set_game_mode():
	match Globals.game_mode:
		Globals.GameModes.SINGLE_PLAYER:
			turn_system.current_system = SinglePlayer.instance()
		Globals.GameModes.VERSUS:
			turn_system.current_system = Versus.instance()
	turn_system.add_child(turn_system.current_system)


func spawn_random_coins():
	var switches = get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES)
	switches.shuffle()
	for switch in switches.slice(1, INITIAL_COINS):
		balls.spawn_coin(switch.coin_spawn_position.global_position)
		yield(get_tree().create_timer(0.2), "timeout")


func spawn_random_coin_bag():
	yield(get_tree().create_timer(0.5), "timeout")
	var switches = get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES)
	switches.shuffle()
	for switch in switches:
		if !switch.has_ball:
			power_ups.spawn_coin_bag(switch.coin_spawn_position.global_position + Vector2(0, 16))
			return


func throw_random_bombs(quantity):
	var slots = get_tree().get_nodes_in_group(Globals.GROUP_SLOTS)
	slots.shuffle()
	slots.resize(quantity)
	for slot in slots:
		slot.bomb_alert()
		yield(slot.animated_sprite, "animation_finished")
		balls.spawn_bomb(slot.global_position)


func throw_random_coins(quantity):
	var slots = get_tree().get_nodes_in_group(Globals.GROUP_SLOTS)
	slots.shuffle()
	slots.resize(quantity)
	for slot in slots:
		balls.spawn_coin(slot.global_position)
		yield(get_tree().create_timer(0.3), "timeout")


func _on_TurnSystem_round_ended(current_round):
	if current_round > 0 && current_round < Globals.FINAL_ROUND:
		throw_random_bombs(current_round)
		yield(balls, "no_moving_balls")
		spawn_random_coin_bag()
