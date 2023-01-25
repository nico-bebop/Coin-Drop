extends Area2D

const IMPULSE = Vector2(65, 0)

signal combine(value)


func _on_CoinCollision_body_entered(_body):
	var coin = get_parent()
	if !coin.is_moving:
		push_other(coin)

	var bodies = get_overlapping_bodies()
	if bodies.size() > 1:
		combine(bodies)


func push_other(coin):
	if coin.orientation == "LEFT":
		coin.apply_central_impulse(IMPULSE)
	elif coin.orientation == "RIGHT":
		coin.apply_central_impulse(-IMPULSE)


func combine(coins):
	if coins[0].is_moving && coins[1].is_moving:
		coins[0].queue_free()
		emit_signal("combine", coins[0].value + coins[1].value)
