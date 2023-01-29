extends Label

export(String) var player_name

var total_score = 0
var round_score = [0, 0, 0, 0]
var required_score = [10, 40, 20, 80]


func _ready():
	set_label_text()


func update_score(player, current_round, value):
	if text.begins_with(player):
		total_score += value
		round_score[current_round] += value
		set_label_text()


func _on_Board_round_ended(_next_round, _next_score):
	set_label_text()


func set_label_text():
	text = player_name
	text += "\nR1 : " + str(round_score[0]) + "/" + str(required_score[0])
	text += "\nR2 : " + str(round_score[1]) + "/" + str(required_score[1])
	text += "\nR3 : " + str(round_score[2]) + "/" + str(required_score[2])
	text += "\nR4 : " + str(round_score[3]) + "/" + str(required_score[3])
	text += "\nTOTAL: " + str(total_score)
