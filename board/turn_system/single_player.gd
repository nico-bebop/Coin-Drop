extends "res://board/turn_system/turn_system.gd"

const GAME_OVER = ["Game", "Over!"]
const GET = "GET\n"
const POINTS = " POINTS"
const ROUND_SCORE = "\nROUND SCORE\n"
const COMPLETED = "COMPLETED!\n"
const FAILED = "FAILED!\n"

onready var player = $Player
onready var objective = $Player/Objective/Scoreboard/Score
onready var objective_animation = $Player/Objective/AnimationPlayer
onready var turn_system = get_parent()


func _ready():
	objective_animation.play("Appear")


func change_turn():
	if objective_failed():
		objective.text = FAILED + ROUND_SCORE
		update_round_score()
		turn_system.signal_game_over()
		return
	
	if round_ended():
		turn_system.change_round()
		if current_round != Globals.FINAL_ROUND:
			start_round()
		else:
			turn_system.signal_game_over()
		return

	player.set_label_text()
	turn_system.signal_turn_ready()


func start():
	start_round()
	set_turn(player)


func round_ended():
	return player.coins_left == 0


func start_round():
	player.coins_left = player.coins_per_round
	player.reset_scoreboard()


func set_objective_text():
	if player.required_score_met():
		objective.text = COMPLETED + ROUND_SCORE
	else:
		objective.text = GET + str(player.required_score[current_round]) + POINTS + ROUND_SCORE
	update_round_score()


func objective_failed():
	return player.coins_left == 0 && !player.required_score_met()


func update_round_score():
	objective.text += str(player.round_score) + "/" + str(player.required_score[current_round])


func game_over():
	return GAME_OVER
