extends Node2D

var GameOver = preload("res://UI/GameOver.tscn")

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
signal round_ended(next_round, next_score)


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
	if player1.round_score[current_round] >= required_score || player2.round_score[current_round] >= required_score:
		set_round(current_round + 1)
		if current_round == 4:
			game_over()
			return
		set_required_score()
		emit_signal("round_ended", current_round, required_score)


func game_over():
	var game_over = GameOver.instance()
	var winner = player1.player_name if player1.total_score > player2.total_score else player2.player_name
	add_child(game_over)
	game_over.dialog_text = winner + " WINS"
	game_over.popup_centered()
	slots.change_slots_state(false)


func change_outlines(active_player, inactive_player):
	active_player.get("custom_fonts/font").outline_size = 1
	inactive_player.get("custom_fonts/font").outline_size = 0


func get_active_coins():
	if is_inside_tree():
		for coin in get_tree().get_nodes_in_group("Coins"):
			if !coin.sleeping:
				return
		next_turn()
