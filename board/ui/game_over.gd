extends AcceptDialog


func _ready():
	get_ok().text = Globals.PLAY_AGAIN


func _on_GameOver_confirmed():
	var _err = get_parent().get_tree().reload_current_scene()
