extends Label

export(String) var player_name

func _ready():
	text = player_name + "\nSCORE: 0"


func _on_BoardBottom_update_score(player, value):
	if text.begins_with(player):
		text = player_name + "\nSCORE: " + str(value)
