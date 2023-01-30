extends Area2D

const IMPULSE = Vector2(65, 0)

signal combine(value)


func _on_CoinCollision_body_entered(_body):
	var coin = get_parent()
	if coin.sleeping:
		push_other(coin)

	var bodies = get_overlapping_bodies()
	if bodies.size() > 1:
		combine(bodies)


func push_other(coin):
	match coin.orientation:
		"LEFT":
			coin.apply_central_impulse(IMPULSE)
		"RIGHT":
			coin.apply_central_impulse(-IMPULSE)


func combine(coins):
	if !coins[0].sleeping && !coins[1].sleeping:
		coins[0].queue_free()
		emit_signal("combine", coins[0].multiplier + coins[1].multiplier)
