extends Node2D

var current_turn setget set_turn
var active_coins

onready var player1 = $UserInterface/PlayerScore1
onready var player2 = $UserInterface/PlayerScore2


func _ready():
	randomize()
	if randi() % 2 == 0:
		set_turn(player1.player_name)
	else:
		set_turn(player2.player_name)


func change_turn():
	match current_turn:
		player1.player_name:
			set_turn(player2.player_name)
		player2.player_name:
			set_turn(player1.player_name)


func set_turn(player):
	current_turn = player
	match player:
		player1.player_name:
			player1.get("custom_fonts/font").outline_size = 1
			player2.get("custom_fonts/font").outline_size = 0
		player2.player_name:
			player1.get("custom_fonts/font").outline_size = 0
			player2.get("custom_fonts/font").outline_size = 1


func get_active_coins():
	if get_owner() != null:
		for coin in get_tree().get_nodes_in_group("Coins"):
			if coin.is_moving:
				return
		change_turn()
