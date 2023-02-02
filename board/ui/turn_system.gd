extends Control

const GameOver = preload("res://board/ui/game_over.tscn")

var current_turn setget set_turn
var current_round = 0 setget set_round
var scores = [10, 40, 20, 80]

onready var bottom_slots = $"../BottomSlots"
onready var slots = $"../Slots"
onready var player1 = $Player1
onready var player2 = $Player2

signal turn_ready
signal round_ended(current_round)


func _on_Board_board_ready():
	change_active_player(player1, player2)


func set_current_player():
	match current_turn:
		player1:
			change_active_player(player2, player1)
		player2:
			change_active_player(player1, player2)


func check_change_round():
	if (player1.required_score_met() || player2.required_score_met()) && current_turn == player2:
		set_round(current_round + 1)
		update_slots_score(current_round)
		emit_signal("round_ended", current_round)


func change_active_player(active_player, inactive_player):
	set_turn(active_player)
	active_player.set_active(true)
	inactive_player.set_active(false)


func update_slots_score(next_round):
	if next_round < Globals.FINAL_ROUND:
		for slot in bottom_slots.get_children():
			slot.set_score(slot.scores[next_round])


func _on_Coins_no_moving_coins():
	check_change_round()
	if current_round == Globals.FINAL_ROUND:
		game_over()
		return

	set_current_player()
	emit_signal("turn_ready")


func game_over():
	var game_over = GameOver.instance()
	add_child(game_over)
	game_over.check_winner(player1, player2)
	game_over.popup_centered()
	slots.change_slots_state(false)


func set_turn(value):
	current_turn = value


func set_round(value):
	current_round = value
