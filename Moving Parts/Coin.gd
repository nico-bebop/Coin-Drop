extends RigidBody2D

var orientation = null
var is_moving = true
var counter = 0

onready var CoinCollision = $CoinCollision


func _ready():
	CoinCollision.connect("coins_combined", self, "change_sprite")


func change_sprite():
	match counter:
		0:
			$Sprite.texture = load("res://Moving Parts/coin2.png")
		1:
			$Sprite.texture = load("res://Moving Parts/coin3.png")
	counter += 1


func _on_Coin_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")


func _on_Coin_body_exited(_body):
	is_moving = true
