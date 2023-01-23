extends RigidBody2D

const IMPULSE = Vector2(65, 0)

var orientation = null
var is_moving = true


func _on_Coin_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")


func _on_Coin_body_exited(_body):
	is_moving = true


func _on_CoinCollision_area_entered(_area):
	if !is_moving:
		if orientation == "LEFT":
			apply_central_impulse(IMPULSE)
		elif orientation == "RIGHT":
			apply_central_impulse(-IMPULSE)
