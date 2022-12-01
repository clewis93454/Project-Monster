extends KinematicBody2D


var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()
onready var _animated_sprite = $AnimatedSprite

func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("player_up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
		_animated_sprite.play("up_idle")
		
	if Input.is_action_pressed("player_down"):
		velocity.y += 1
		direction = Vector2(0, 1)
		_animated_sprite.play("down_idle")
		
	if Input.is_action_pressed("player_left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		_animated_sprite.set_flip_h(false)
		_animated_sprite.play("side_idle")
		
	if Input.is_action_pressed("player_right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		_animated_sprite.set_flip_h(true)
		_animated_sprite.play("right_idle")

	
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * 200)

func _physics_process(delta):
	read_input()
