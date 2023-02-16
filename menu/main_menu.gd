extends Control


func _ready():
	yield(SceneTransition.animation_player, "animation_finished")
	$AnimationPlayer.play("Appear")


func _on_SinglePlayer_pressed():
	$ButtonClickAudio.play()
	start_game(Globals.GameModes.SINGLE_PLAYER)


func _on_Versus_pressed():
	$ButtonClickAudio.play()
	start_game(Globals.GameModes.VERSUS)


func start_game(game_mode):
	Globals.game_mode = game_mode
	SceneTransition.change_scene("res://board/board.tscn")
