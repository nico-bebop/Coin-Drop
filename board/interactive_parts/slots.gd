extends Node2D

onready var animation_player = $AnimationPlayer


func _on_Board_board_ready():
	animation_player.play("Highlight")
	change_slots_state(true)


func _on_TurnSystem_turn_ready():
	change_slots_state(true)
	animation_player.play("Highlight")


func change_slots_state(value = false):
	for slot in get_tree().get_nodes_in_group(Globals.GROUP_SLOTS):
		slot.clickable = value
