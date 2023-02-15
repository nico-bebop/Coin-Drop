extends "res://board/turn_system/turn_system.gd"

const GAME_OVER = ["Game", "Over!"]
const GET = "GET\n"
const POINTS_THIS_ROUND = " POINTS\nTHIS ROUND\n"

onready var player = $Player
onready var objective = $Player/Objective/Scoreboard/Score
onready var objective_animation = $Player/Objective/AnimationPlayer


func _ready():
	objective_animation.play("Appear")


func start():
	start_round()
	set_turn(player)


func next_turn():
	player.set_label_text()


func should_change_round():
	return player.coins_left == 0 || str(player.coins_left) == Globals.NO_SCORE


func start_round():
	player.coins_left = player.coins_per_round
	player.reset_scoreboard()


func set_objective_text():
	if current_round == Globals.FINAL_ROUND:
		objective.text = ""
		return

	objective.text = GET + str(player.required_score[current_round]) + POINTS_THIS_ROUND
	objective.text += str(player.round_score) + "/" + str(player.required_score[current_round])


func game_over():
	return GAME_OVER
