extends Node2D

const GameOver = preload("res://board/ui/game_over.tscn")

onready var turn_system = $UserInterface/TurnSystem
onready var slots = $Slots


func check_active_coins():
	if is_inside_tree():
		for coin in get_tree().get_nodes_in_group("Coins"):
			if !coin.sleeping:
				return
		turn_system.next_turn()


func _on_TurnSystem_game_over():
	var game_over = GameOver.instance()
	add_child(game_over)
	game_over.check_winner(turn_system.player1, turn_system.player2)
	game_over.popup_centered()
	slots.change_slots_state(false)
