extends Control


func _on_SinglePlayer_pressed():
	pass


func _on_Versus_pressed():
	var _err = get_tree().change_scene("res://board/board.tscn")
