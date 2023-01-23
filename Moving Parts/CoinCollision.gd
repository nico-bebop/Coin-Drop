extends Area2D

const IMPULSE = Vector2(65, 0)

signal coins_combined


func _on_CoinCollision_body_entered(_body):
	var coin = get_parent()
	if !coin.is_moving:
		if coin.orientation == "LEFT":
			coin.apply_central_impulse(IMPULSE)
		elif coin.orientation == "RIGHT":
			coin.apply_central_impulse(-IMPULSE)

	var bodies = get_overlapping_bodies()
	if bodies.size() > 1:
		if bodies[0].is_moving && bodies[1].is_moving:
			print("2 coins")
			bodies[1].queue_free()
			emit_signal("coins_combined")
