extends Area2D

var Coin = preload("res://Moving Parts/Coin.tscn")

#TODO: replace with turn system
var clickable = true
onready var timer = $Timer

#TODO: replace with animated sprite
onready var coin_sprite = $CoinSprite


func _on_Slot_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") && clickable:
		timer.start()
		clickable = false
		coin_sprite.visible = false

		var coin = Coin.instance()
		coin.position = global_position
		get_tree().current_scene.add_child(coin)


func _on_Timer_timeout():
	clickable = true


func _on_Slot_mouse_entered():
	coin_sprite.visible = true


func _on_Slot_mouse_exited():
	coin_sprite.visible = false
