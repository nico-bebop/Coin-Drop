extends Area2D

signal combine(value)


func _on_CoinCollision_body_entered(_body):
	var coin = get_parent()
	if !coin.is_moving:
		coin.direction = coin.orientation

	var bodies = get_overlapping_bodies()
	if bodies.size() > 1:
		combine(bodies)


func combine(coins):
	if coins[0].is_moving && coins[1].is_moving:
		emit_signal("combine", coins[0].multiplier + coins[1].multiplier)
		coins[0].queue_free()
