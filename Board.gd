extends Node2D

var current_turn setget set_turn
var active_coins

onready var player1 = $UserInterface/PlayerScore1
onready var player2 = $UserInterface/PlayerScore2
onready var slots = $Slots

signal turn_ready


func _ready():
	randomize()
	if randi() % 2 == 0:
		set_turn(player1.player_name)
		change_outlines(player1, player2)
	else:
		set_turn(player2.player_name)
		change_outlines(player2, player1)


func next_turn():
	match current_turn:
		player1.player_name:
			set_turn(player2.player_name)
			change_outlines(player2, player1)
		player2.player_name:
			set_turn(player1.player_name)
			change_outlines(player1, player2)
	emit_signal("turn_ready")


func set_turn(player):
	current_turn = player


func change_outlines(active_player, inactive_player):
	set_turn(active_player.player_name)
	active_player.get("custom_fonts/font").outline_size = 1
	inactive_player.get("custom_fonts/font").outline_size = 0


func get_active_coins():
	if is_inside_tree():
		yield(get_tree().create_timer(0.1), "timeout")
		for coin in get_tree().get_nodes_in_group("Coins"):
			if coin.is_moving:
				return
		next_turn()
