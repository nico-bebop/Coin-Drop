extends Control


func _ready():
	$TripleSign/VolumeControls.load_music_options()
	yield(SceneTransition.animation_player, "animation_finished")
	$AnimationPlayer.play("Appear")


func start_game(game_mode):
	$ButtonClickAudio.play()
	Globals.game_mode = game_mode
	SceneTransition.change_scene("res://board/board.tscn")


func _on_SinglePlayer_pressed():
	start_game(Globals.GameModes.SINGLE_PLAYER)


func _on_Versus_pressed():
	start_game(Globals.GameModes.VERSUS)
