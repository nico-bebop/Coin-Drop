extends Control

export(String) var player_name

var active setget set_active
var total_score = 0
var round_score = [0, 0, 0, 0]
var required_score = [10, 40, 20, 80]

onready var p_name = $PlayerName
onready var score = $Score
onready var turn_system = $".."


func _ready():
	p_name.text = player_name
	set_label_text()


func update_score(value):
	if turn_system.current_turn == self:
		total_score += value
		round_score[turn_system.current_round] += value
		set_label_text()


func set_label_text():
	score.text = "\nR1 : " + str(round_score[0]) + "/" + str(required_score[0])
	score.text += "\nR2 : " + str(round_score[1]) + "/" + str(required_score[1])
	score.text += "\nR3 : " + str(round_score[2]) + "/" + str(required_score[2])
	score.text += "\nR4 : " + str(round_score[3]) + "/" + str(required_score[3])
	score.text += "\nTOTAL: " + str(total_score)


func required_score_met():
	return round_score[turn_system.current_round] >= required_score[turn_system.current_round]


func change_outlines():
	p_name.get("custom_fonts/font").outline_size = 1 if active else 0


func set_active(value):
	active = value
	change_outlines()


func _on_TurnSystem_round_ended():
	set_label_text()
