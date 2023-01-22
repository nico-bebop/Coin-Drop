extends RigidBody2D

var orientation = null
var is_moving = true


func _on_Coin_body_entered(body):
	print("_on_Coin_body_entered")
	is_moving = false
	orientation = body.get("orientation")


func _on_Coin_body_exited(body):
	print("_on_Coin_body_exited")
	is_moving = true


func _on_CoinCollision_area_entered(area):
	print("coin area entered")
	if is_moving:
		global_position += Vector2(8, 0)
#		if orientation == "LEFT":
#			global_position += Vector2(8, 0)
#		elif orientation == "RIGHT":
#			global_position += Vector2(-8, 0)

