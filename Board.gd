extends Node2D

var Coin = preload("res://Moving Parts/Coin.tscn")


func _physics_process(_delta):
	if Input.is_action_just_pressed("click"):
		var coin = Coin.instance()
		coin.position = get_global_mouse_position()
		add_child(coin)
