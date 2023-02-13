extends Control

export(String) var player_name
export(int) var coins_per_round = 5

const COINS_LEFT = "COINS LEFT\n"
const ROUND_SCORE = "ROUND SCORE\n"
const TOTAL_SCORE = "\nTOTAL SCORE\n"

var coins_left = coins_per_round
var total_score = 0
var round_score = 0
var required_score = [10, 40, 20, 80, Globals.NO_SCORE]

onready var animation_player = $AnimationPlayer
onready var coin_meter = $CoinMeter
onready var score = $Score
onready var turn_system = get_parent()
onready var tween = $Tween


func _ready():
	$PlayerName.text = player_name


func reset_scoreboard():
	empty_coin_meter()
	set_label_text()
	yield(tween, "tween_completed")

	if turn_system.current_round != Globals.FINAL_ROUND:
		update_coin_meter()
		yield(tween, "tween_completed")
		set_max_coin_meter()


func set_label_text():
	if turn_system.current_round == Globals.FINAL_ROUND:
		round_score = Globals.NO_SCORE
		coins_left = Globals.NO_SCORE

	match Globals.game_mode:
		Globals.GameModes.SINGLE_PLAYER:
			score.text = COINS_LEFT + str(coins_left)
		Globals.GameModes.VERSUS:
			score.text = ROUND_SCORE + str(round_score) + "/" + str(required_score[turn_system.current_round])

	score.text += TOTAL_SCORE + str(total_score)


func required_score_met():
	return round_score >= required_score[turn_system.current_round]


func highlight(active):
	var _err = animation_player.play("Highlight") if active else animation_player.play("RESET")


func update_coin_meter():
	tween.interpolate_property($CoinMeter, "value", null, round_score, 0.5)
	tween.start()


func set_max_coin_meter():
	coin_meter.max_value = required_score[turn_system.current_round]
	coin_meter.step = coin_meter.max_value / 20


func empty_coin_meter():
	round_score = 0
	tween.interpolate_property($CoinMeter, "value", null, round_score, 1)
	tween.start()


func update_score(value):
	total_score += value
	round_score += value
	set_label_text()
	update_coin_meter()
