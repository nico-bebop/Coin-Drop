extends Control

export(String) var player_name

const ROUND_SCORE = "ROUND SCORE:\n"
const TOTAL_SCORE = "\nTOTAL SCORE:\n "

var active setget set_active
var total_score = 0
var round_score = [0, 0, 0, 0, Globals.NO_SCORE]
var required_score = [10, 40, 20, 80, Globals.NO_SCORE]

onready var animation_player = $AnimationPlayer
onready var coin_meter = $CoinMeter
onready var score = $Score
onready var turn_system = $".."


func _ready():
	$PlayerName.text = player_name
	set_label_text()
	set_max_coin_meter()


func update_score(value):
	if turn_system.current_turn == self:
		total_score += value
		round_score[turn_system.current_round] += value
		set_label_text()
		update_coin_meter()


func set_label_text():
	var r = turn_system.current_round
	score.text = ROUND_SCORE + str(round_score[r]) + "/" + str(required_score[r]) + TOTAL_SCORE + str(total_score)


func required_score_met():
	return round_score[turn_system.current_round] >= required_score[turn_system.current_round]


func highlight_active_player():
	# warning-ignore:standalone_ternary
	animation_player.play("Highlight") if active else animation_player.play("RESET")


func update_coin_meter():
	coin_meter.value = round_score[turn_system.current_round]


func set_max_coin_meter():
	coin_meter.max_value = required_score[turn_system.current_round]
	coin_meter.step = coin_meter.max_value / 10


func set_active(value):
	active = value
	highlight_active_player()


func _on_TurnSystem_round_ended(current_round):
	set_label_text()
	if current_round != Globals.FINAL_ROUND:
		update_coin_meter()
		set_max_coin_meter()
