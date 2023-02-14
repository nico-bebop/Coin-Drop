extends Control

onready var animation_player = $"../AnimationPlayer"
onready var label = $Label


func _on_Board_board_ready():
	round_start_animation(0)
	animation_player.play("ArrowsHint")


func _on_TurnSystem_round_ended(current_round):
	round_start_animation(current_round)


func round_start_animation(current_round):
	if current_round != Globals.FINAL_ROUND:
		animation_player.play("RoundChange")
		label.text = Globals.ROUNDS[current_round]
