extends AcceptDialog


func _on_GameOver_confirmed():
	var _err = get_parent().get_tree().reload_current_scene()


func check_winner(player1, player2):
	if player1.total_score > player2.total_score:
		dialog_text = player1.player_name + " WINS"
	elif player2.total_score > player1.total_score:
		dialog_text = player2.player_name + " WINS"
	else:
		dialog_text = "TIE"
