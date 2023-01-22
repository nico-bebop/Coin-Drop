extends RigidBody2D

var orientation = null
var is_moving = true

func _on_Coin_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")
	print(orientation)


func _on_CoinCollision_area_entered(_area):
	if !is_moving:
		if orientation == "LEFT":
			global_position += Vector2(8, 0)
		elif orientation == "RIGHT":
			global_position += Vector2(-8, 0)


func _on_Coin_body_exited(body):
	is_moving = true
