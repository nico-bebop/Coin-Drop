extends Node2D

signal update_score(value)
signal check_moving_balls


func _on_Board_board_ready():
	update_slots_score(0)


func _on_TurnSystem_round_ended(current_round):
	update_slots_score(current_round)


func coin_entered_slot(value):
	emit_signal("update_score", value)


func ball_entered_slot():
	emit_signal("check_moving_balls")


func update_slots_score(this_round):
	if this_round < Globals.FINAL_ROUND:
		for slot in get_children():
			slot.set_score(slot.scores[this_round])
			slot.get("animation_player").play("ScoreChange")
			yield(slot.get("animation_player"), "animation_finished")
