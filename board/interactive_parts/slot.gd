extends Area2D

const Coin = preload("res://board/moving_parts/coin.tscn")

var clickable = false

onready var coin_sprite = $CoinSprite
onready var balls = $"../../Balls"

signal coin_dropped


func _on_Slot_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") && clickable:
		if !coin_sprite.visible:
			coin_sprite.visible = true
			return

		emit_signal("coin_dropped")
		yield(coin_sprite, "animation_finished")
		coin_sprite.visible = false
		spawn_coin()


func spawn_coin():
	var coin = Coin.instance()
	coin.position = global_position
	balls.add_child(coin)


func _on_Slot_mouse_entered():
	if clickable:
		coin_sprite.visible = true


func _on_Slot_mouse_exited():
	if clickable:
		coin_sprite.visible = false
