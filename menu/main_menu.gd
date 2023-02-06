extends Control


func _on_SinglePlayer_pressed():
	start_game(Globals.GameModes.SINGLE_PLAYER)


func _on_Versus_pressed():
	start_game(Globals.GameModes.VERSUS)


func start_game(game_mode):
	Globals.game_mode = game_mode
	var _err = get_tree().change_scene("res://board/board.tscn")
