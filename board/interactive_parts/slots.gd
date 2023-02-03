extends Node2D

onready var animation_player = $AnimationPlayer


func _on_Board_board_ready():
	enable_slots()


func _on_TurnSystem_turn_ready():
	enable_slots()


func _on_TurnSystem_game_over(_players):
	disable_slots()


func enable_slots():
	animation_player.play("Highlight")
	change_slots_state(true)


func disable_slots():
	animation_player.play("RESET")
	change_slots_state(false)


func change_slots_state(value):
	for slot in get_tree().get_nodes_in_group(Globals.GROUP_SLOTS):
		slot.clickable = value
