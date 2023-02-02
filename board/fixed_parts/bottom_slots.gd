extends Node2D


func _on_Board_board_ready():
	update_slots_score(0)


func _on_TurnSystem_round_ended(current_round):
	update_slots_score(current_round)


func update_slots_score(this_round):
	if this_round < Globals.FINAL_ROUND:
		for slot in get_children():
			slot.set_score(slot.scores[this_round])
			slot.get("animation_player").play("ScoreChange")
			yield(slot.get("animation_player"), "animation_finished")
