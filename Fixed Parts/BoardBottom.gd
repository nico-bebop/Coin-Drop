extends Node2D

var player_score = 0

signal update_score(player, value)


func _ready():
	for slot in self.get_children():
		slot.set_score(2)


func _on_ScoreSlot_add_score(value):
	var player = get_tree().current_scene.current_turn
	player_score += value
	emit_signal("update_score", player, player_score)
