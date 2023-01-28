extends Node2D

var active_coins
var current_turn setget set_turn
var current_round = 0 setget set_round
var required_score

enum scores {
	ROUND_ONE = 10,
	ROUND_TWO = 40,
	ROUND_THREE = 20,
	ROUND_FOUR = 80,
}

onready var player1 = $UserInterface/PlayerScore1
onready var player2 = $UserInterface/PlayerScore2
onready var slots = $Slots

signal turn_ready
signal round_ended(next_round)


func _ready():
	randomize()
	if randi() % 2 == 0:
		set_turn(player1.player_name)
		change_outlines(player1, player2)
	else:
		set_turn(player2.player_name)
		change_outlines(player2, player1)
	set_required_score()

func next_turn():
	match current_turn:
		player1.player_name:
			set_turn(player2.player_name)
			change_outlines(player2, player1)
		player2.player_name:
			set_turn(player1.player_name)
			change_outlines(player1, player2)
	emit_signal("turn_ready")
	check_change_round()


func set_turn(player):
	current_turn = player


func set_round(current):
	current_round = current
	set_required_score()


func set_required_score():
	match current_round:
		0:
			required_score = scores.ROUND_ONE
		1:
			required_score = scores.ROUND_TWO
		2:
			required_score = scores.ROUND_THREE
		3:
			required_score = scores.ROUND_FOUR


func check_change_round():
	if player1.score >= required_score || player2.score >= required_score:
		set_round(current_round + 1)
		emit_signal("round_ended", current_round)


func change_outlines(active_player, inactive_player):
	active_player.get("custom_fonts/font").outline_size = 1
	inactive_player.get("custom_fonts/font").outline_size = 0


func get_active_coins():
	if is_inside_tree():
		yield(get_tree().create_timer(0.1), "timeout")
		for coin in get_tree().get_nodes_in_group("Coins"):
			if coin.is_moving:
				return
		next_turn()
