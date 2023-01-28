extends Node2D


func _on_Board_round_ended(next_round):
	change_slots_scores(next_round)


func change_slots_scores(next):
	for slot in get_children():
		slot.set_score(slot.score_array[next])
