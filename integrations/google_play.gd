extends Node

const CLIENT_ID = "311116801314-jeauebh6glo66fv8eedbnes5d0tj7hat.apps.googleusercontent.com"
const LEADERBOARD_ID = "CgkIosqGgIcJEAIQAA"

var service


func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		service = Engine.get_singleton("GodotPlayGamesServices")
		service.init(true, true, true, "")
	if service:
		connect_signals()


func sign_in():
	service.signIn()


func submit_score(score):
	if service && service.isSignedIn():
		service.submitLeaderBoardScore(LEADERBOARD_ID, score)
		Globals.offline_score = 0
	else:
		Globals.offline_score = score


func show_leaderboard():
	if service:
		if !service.isSignedIn():
			sign_in()
		else:
			if Globals.offline_score != 0:
				submit_score(Globals.offline_score)
			service.showLeaderBoard(LEADERBOARD_ID)


func connect_signals():
	service.connect("_on_sign_in_success", self, "_on_sign_in_success")  # account_id: String
	service.connect("_on_sign_in_failed", self, "_on_sign_in_failed")  # error_code: int
	service.connect("_on_leaderboard_score_submitted", self, "_on_leaderboard_score_submitted")  # leaderboard_id: String
	service.connect("_on_leaderboard_score_submitting_failed", self, "_on_leaderboard_score_submitting_failed")  # leaderboard_id: String


func _on_sign_in_success(account_id):
	print("Sign in success - ", account_id)


func _on_sign_in_failed(error_code):
	print("Sign in failed - ", str(error_code))


func _on_leaderboard_score_submitted(leaderboard_id):
	print("Score submitted - ", leaderboard_id)


func _on_leaderboard_score_submitting_failed(leaderboard_id):
	print("Score submitting failed - ", leaderboard_id)
