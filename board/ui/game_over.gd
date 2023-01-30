extends AcceptDialog


func _on_GameOver_confirmed():
	var _err = get_parent().get_tree().reload_current_scene()
