extends Node2D

signal update_score(value)


func _on_Board_board_ready():
	update_slots_score(0)


func _on_TurnSystem_round_ended(current_round):
	update_slots_score(current_round)


func _on_ScoreSlot_coin_scored(value):
	emit_signal("update_score", value)


func update_slots_score(this_round):
	if this_round < Globals.FINAL_ROUND:
		for slot in get_children():
			slot.set_score(slot.scores[this_round])
			slot.get("animation_player").play("ScoreChange")
			yield(slot.get("animation_player"), "animation_finished")