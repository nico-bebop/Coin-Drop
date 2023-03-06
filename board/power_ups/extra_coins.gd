extends "res://board/power_ups/power_up.gd"

const EXTRA_COINS = 3

onready var player = $"../../TurnSystem/SinglePlayer/Player"


func _ready():
	pickup_text = str(EXTRA_COINS) + pickup_text
	

func _on_BallCollision_body_entered(body):
	disappear()

	if body.is_in_group(Globals.GROUP_COINS):
		pick_up()
		player.coins_left += EXTRA_COINS
		player.set_label_text()
		$PowerUpAudio.play()
		yield($PowerUpAudio, "finished")

	elif body.is_in_group(Globals.GROUP_BOMBS):
		$DestroyAudio.play()
		yield($DestroyAudio, "finished")

	queue_free()
