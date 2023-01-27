extends Node2D

signal update_score(player, value)


func _ready():
	for slot in self.get_children():
		slot.set_score(2)


func _on_ScoreSlot_add_score(value):
	var player = get_tree().current_scene.current_turn
	emit_signal("update_score", player, value)
