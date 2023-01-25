extends Area2D

var Coin = preload("res://Moving Parts/Coin.tscn")
var clickable = true

onready var timer = $Timer
onready var coin_sprite = $CoinSprite


func _on_Slot_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") && clickable:
		wait_for_coin()
		spawn_coin()


func wait_for_coin():
	timer.start()
	clickable = false
	yield(coin_sprite, "animation_finished")
	coin_sprite.visible = false


func spawn_coin():
	yield(coin_sprite, "animation_finished")
	var coin = Coin.instance()
	coin.position = global_position
	get_tree().current_scene.add_child(coin)


func _on_Timer_timeout():
	clickable = true


func _on_Slot_mouse_entered():
	if clickable:
		coin_sprite.visible = true


func _on_Slot_mouse_exited():
	if clickable:
		coin_sprite.visible = false
