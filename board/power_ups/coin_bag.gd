extends "res://board/power_ups/power_up.gd"

const COINS_IN_BAG = 5

signal throw_coins(quantity)


func _ready():
	var _err = connect("throw_coins", get_tree().current_scene, "throw_random_coins")


func _on_BallCollision_body_entered(body):
	disappear()

	if body.is_in_group(Globals.GROUP_COINS):
		emit_signal("throw_coins", COINS_IN_BAG)
		for coin in COINS_IN_BAG:
			power_up_audio.play()
			yield(get_tree().create_timer(0.3), "timeout")

	elif body.is_in_group(Globals.GROUP_BOMBS):
		destroy_audio.play()
		yield(destroy_audio, "finished")

	queue_free()
