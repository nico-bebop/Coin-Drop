extends Label

export(String) var player_name

var total_score = 0
var round_score = 0
var required_score = 10


func _ready():
	set_label_text()


func update_score(player, value):
	if text.begins_with(player):
		total_score += value
		round_score += value
		set_label_text()


func _on_Board_round_ended(_next_round, next_score):
	round_score = 0
	required_score = next_score
	set_label_text()


func set_label_text():
	text = player_name + "\nSCORE: " + str(total_score)
	text += "\nROUND : " + str(round_score) + "/" + str(required_score)
