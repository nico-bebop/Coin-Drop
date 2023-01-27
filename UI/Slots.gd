extends Node2D


func _on_Board_turn_ready():
	change_slots_state(true)


func change_slots_state(value = false):
	for slot in get_children():
		slot.clickable = value
