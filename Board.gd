extends Node2D


func _on_BottomArea_body_entered(body):
	body.queue_free()
