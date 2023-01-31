extends Control

export(String) var player_name

const ROUND_SCORE = "ROUND SCORE:\n"
const TOTAL_SCORE = "\nTOTAL SCORE:\n "

var active setget set_active
var total_score = 0
var round_score = [0, 0, 0, 0]
var required_score = [10, 40, 20, 80]

onready var animation_player = $PlayerName/AnimationPlayer
onready var score = $Score
onready var turn_system = $".."


func _ready():
	$PlayerName.text = player_name
	set_label_text()


func update_score(value):
	if turn_system.current_turn == self:
		total_score += value
		round_score[turn_system.current_round] += value
		set_label_text()


func set_label_text():
	var r = turn_system.current_round
	score.text = ROUND_SCORE + str(round_score[r]) + "/" + str(required_score[r]) + TOTAL_SCORE + str(total_score)


func required_score_met():
	return round_score[turn_system.current_round] >= required_score[turn_system.current_round]


func change_outlines():
	animation_player.play("Highlight") if active else animation_player.play("RESET")


func set_active(value):
	active = value
	change_outlines()


func _on_TurnSystem_round_ended():
	if turn_system.current_round != Globals.FINAL_ROUND:
		set_label_text()
