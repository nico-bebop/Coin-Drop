extends Node

const CLIENT_ID = "311116801314-jeauebh6glo66fv8eedbnes5d0tj7hat.apps.googleusercontent.com"
const LEADERBOARD_ID = "CgkIosqGgIcJEAIQAA"

var play_games_services


func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_games_services = Engine.get_singleton("GodotPlayGamesServices")
		play_games_services.init(true, true, true, "")
	if play_games_services:
		connect_signals()
		sign_in()


func sign_in():
	play_games_services.signIn()


func connect_signals():
	play_games_services.connect("_on_sign_in_success", self, "_on_sign_in_success")  # account_id: String
	play_games_services.connect("_on_sign_in_failed", self, "_on_sign_in_failed")  # error_code: int
	play_games_services.connect("_on_leaderboard_score_submitted", self, "_on_leaderboard_score_submitted")  # leaderboard_id: String
	play_games_services.connect("_on_leaderboard_score_submitting_failed", self, "_on_leaderboard_score_submitting_failed")  # leaderboard_id: String


func _on_sign_in_success(account_id):
	print("Sign in success - ", account_id)


func _on_sign_in_failed(error_code):
	print("Sign in failed - ", str(error_code))


func _on_leaderboard_score_submitted(leaderboard_id):
	print("Score submitted - ", leaderboard_id)


func _on_leaderboard_score_submitting_failed(leaderboard_id):
	print("Score submitting failed - ", leaderboard_id)


func submit_score(score):
	if play_games_services:
		play_games_services.submitLeaderBoardScore(LEADERBOARD_ID, score)


func show_leaderboard():
	if play_games_services:
		play_games_services.showLeaderBoard(LEADERBOARD_ID)
