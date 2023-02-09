extends Control

var current_turn setget set_turn
var current_round = 0 setget set_round
var current_system

signal game_over(message)
signal turn_ready
signal round_ended(current_round)


func _on_Board_board_ready():
	current_system.start()


func _on_Coins_no_moving_coins():
	check_change_round()
	if current_system.current_round == Globals.FINAL_ROUND:
		emit_signal("game_over", current_system.game_over())
		return
	current_system.next_turn()
	emit_signal("turn_ready")


func _on_BottomSlots_update_score(value):
	for player in get_tree().get_nodes_in_group(Globals.GROUP_PLAYERS):
		if current_system.current_turn == player:
			player.update_score(value)


func _on_UpperSlots_subtract_coin():
	for player in get_tree().get_nodes_in_group(Globals.GROUP_PLAYERS):
		if current_system.current_turn == player:
			player.coins_left -= 1
			player.set_label_text()


func check_change_round():
	if current_system.should_change_round():
		current_system.set_round(current_system.current_round + 1)
		emit_signal("round_ended", current_system.current_round)
		current_system.start_round()


func set_turn(value):
	current_turn = value


func set_round(value):
	current_round = value