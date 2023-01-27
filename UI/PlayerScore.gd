extends Label

export(String) var player_name

var score = 0


func _ready():
	text = player_name + "\nSCORE: " + str(score)


func _on_BoardBottom_update_score(player, value):
	if text.begins_with(player):
		score += value
		text = player_name + "\nSCORE: " + str(score)
