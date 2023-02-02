extends Node2D

const GameOver = preload("res://board/ui/game_over.tscn")

signal board_ready


func _ready():
	for switch in get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES):
		switch.set_random_position()
		yield(switch.get("animation_player"), "animation_finished")
	emit_signal("board_ready")


func _on_TurnSystem_game_over(players):
	var game_over = GameOver.instance()
	add_child(game_over)
	game_over.check_winner(players[0], players[1])
	game_over.popup_centered()
