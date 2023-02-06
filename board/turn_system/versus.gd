extends "res://board/turn_system/turn_system.gd"

onready var player1 = $Player1
onready var player2 = $Player2


func start():
	start_round()
	change_active_player(player1, player2)


func next_turn():
	match current_turn:
		player1:
			change_active_player(player2, player1)
		player2:
			change_active_player(player1, player2)


func should_change_round():
	return current_turn == player2 && (player1.required_score_met() || player2.required_score_met())


func change_active_player(active_player, inactive_player):
	set_turn(active_player)
	active_player.highlight(true)
	inactive_player.highlight(false)


func start_round():
	player1.reset_scoreboard()
	player2.reset_scoreboard()


func game_over_message():
	if player1.total_score > player2.total_score:
		return player1.player_name + Globals.WINS
	elif player2.total_score > player1.total_score:
		return player2.player_name + Globals.WINS
	else:
		return Globals.TIE
