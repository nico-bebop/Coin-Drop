extends Area2D

var Coin = preload("res://Moving Parts/Coin.tscn")

#TODO: replace with turn system
var clickable = true
onready var timer = $Timer


func _on_Slot_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") && clickable:
		timer.start()
		clickable = false
		var coin = Coin.instance()
		add_child(coin)


func _on_Timer_timeout():
	clickable = true
