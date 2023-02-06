extends "res://board/turn_system/turn_system.gd"

onready var player = $Player


func start():
	start_round()
	set_turn(player)


func next_turn():
	player.set_label_text()


func should_change_round():
	return player.coins_left == 0


func start_round():
	player.coins_left = 5
	player.reset_scoreboard()


func game_over_message():
	return "GAME OVER!\n" + "SCORE: " + str(player.total_score)
