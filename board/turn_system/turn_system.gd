extends Control

var current_turn setget set_turn
var current_round = 0 setget set_round
var current_system
var first_loss = true

signal game_over(message, first_loss)
signal turn_ready
signal round_ended(current_round)


func _on_Board_board_ready():
	current_system.start()


func _on_Balls_no_moving_balls():
	current_system.change_turn()


func _on_BottomSlots_update_score(value):
	for player in get_tree().get_nodes_in_group(Globals.GROUP_PLAYERS):
		if current_system.current_turn == player:
			player.update_score(value)


func _on_Slotter_subtract_coin():
	for player in get_tree().get_nodes_in_group(Globals.GROUP_PLAYERS):
		if current_system.current_turn == player:
			player.coins_left -= 1
			player.set_label_text()


func change_round():
	current_system.set_round(current_system.current_round + 1)
	emit_signal("round_ended", current_system.current_round)


func set_turn(value):
	current_turn = value


func set_round(value):
	current_round = value


func signal_game_over():
	SceneTransition.lower_music_volume()
	emit_signal("game_over", current_system.game_over(), first_loss)
	first_loss = false


func signal_turn_ready():
	emit_signal("turn_ready")


func _on_AdMob_rewarded(_currency, amount):
	current_system.player.coins_left += amount
	current_system.player.set_label_text()
	current_system.change_turn()
