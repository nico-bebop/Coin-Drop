extends KinematicBody2D

const MAX_SPEED = 250
const ACCELERATION = 200
const LEFT_TARGET = Vector2(20, 2)
const RIGHT_TARGET = Vector2(-20, 2)

export(bool) var is_moving = true
export(String) var orientation = null
export(String) var direction = Globals.DOWN
export(Vector2) var velocity = Vector2.ZERO

var target_position

onready var land_audio = $LandAudio
onready var ball_collision = $BallCollision

signal check_moving_balls


func _ready():
	var _err = connect("check_moving_balls", get_parent(), "check_active_balls")


func _physics_process(delta):
	process_movement(delta)
	velocity = move_and_slide(velocity)
	
	if ball_collision.is_colliding():
		var colliding_ball = ball_collision.get_collider()
		if !colliding_ball.is_moving:
			colliding_ball.direction = colliding_ball.orientation


func process_movement(delta):
	match direction:
		Globals.DOWN:
			velocity = velocity.move_toward(Vector2.DOWN * MAX_SPEED, ACCELERATION * delta)
		Globals.LEFT, Globals.RIGHT:
			global_position = global_position.move_toward(target_position, ACCELERATION / 2.0 * delta)

	if global_position == target_position:
		direction = Globals.DOWN


func _on_SwitchCollision_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")
	land_audio.play()
	emit_signal("check_moving_balls")
	set_target_position()


func _on_SwitchCollision_body_exited(_body):
	is_moving = true


func set_target_position():
	match orientation:
		Globals.LEFT:
			target_position = global_position + LEFT_TARGET
		Globals.RIGHT:
			target_position = global_position + RIGHT_TARGET
