extends "res://board/power_ups/power_up.gd"

const EXTRA_COINS = 3

onready var player = $"../../TurnSystem/SinglePlayer/Player"


func _on_BallCollision_body_entered(body):
	disappear()

	if body.is_in_group(Globals.GROUP_COINS):
		player.coins_left += EXTRA_COINS
		player.set_label_text()
		power_up_audio.play()
		yield(power_up_audio, "finished")

	elif body.is_in_group(Globals.GROUP_BOMBS):
		destroy_audio.play()
		yield(destroy_audio, "finished")

	queue_free()
