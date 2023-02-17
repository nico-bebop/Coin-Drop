extends "res://board/turn_system/turn_system.gd"

const WINS = "wins!"
const TIE = ["Tie!", ""]

onready var player1 = $Player1
onready var player2 = $Player2
onready var turn_system = get_parent()


func start():
	start_round()
	change_active_player(player1, player2)


func change_turn():
	if should_change_round():
		turn_system.change_round()
		if current_round != Globals.FINAL_ROUND:
			start_round()
		else:
			$VictoryAudio.play()
			turn_system.signal_game_over()
		return

	next_turn()
	turn_system.signal_turn_ready()


func next_turn():
	match current_turn:
		player1:
			change_active_player(player2, player1)
		player2, _:
			change_active_player(player1, player2)


func should_change_round():
	return current_turn == player2 && (player1.required_score_met() || player2.required_score_met())


func change_active_player(active_player, inactive_player):
	set_turn(active_player)
	active_player.highlight(true)
	inactive_player.highlight(false)


func start_round():
	set_turn(null)
	player1.highlight(false)
	player2.highlight(false)
	player1.reset_scoreboard()
	player2.reset_scoreboard()


func game_over():
	player1.highlight(false)
	player2.highlight(false)
	return game_over_message()


func game_over_message():
	if player1.total_score > player2.total_score:
		return [player1.player_name, WINS]
	elif player2.total_score > player1.total_score:
		return [player2.player_name, WINS]
	else:
		return TIE
