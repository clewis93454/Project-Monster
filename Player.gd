extends KinematicBody2D

signal enemy_collision

const velocity_multiplier = 200
onready var _animated_sprite = $AnimatedSprite
onready var direction = 'down'

func read_input(delta):
	var velocity: Vector2 = Vector2()
	
	if Input.is_action_pressed("player_up"):
		velocity.y -= 1
		direction = 'up'
		
	if Input.is_action_pressed("player_down"):
		velocity.y += 1
		direction = 'down'
		
	if Input.is_action_pressed("player_left"):
		velocity.x -= 1
		direction = 'left'
		
	if Input.is_action_pressed("player_right"):
		velocity.x += 1
		direction = 'right'
	
	velocity = velocity.normalized()
	
	play_movement_animations(velocity, direction)
	
	var collision = move_and_collide(velocity * velocity_multiplier * delta)
	if collision:
		handle_collision(collision)


func play_movement_animations(velocity, direction):
	if velocity.x == 0 && velocity.y == 0:
		if direction == 'up':
			_animated_sprite.play("up_idle")

		if direction == 'down':
			_animated_sprite.play("down_idle")

		if direction == 'left':
			_animated_sprite.set_flip_h(false)
			_animated_sprite.play("side_idle")

		if direction == 'right':
			_animated_sprite.set_flip_h(true)
			_animated_sprite.play("side_idle")

	else:
		if velocity.x == 0 && velocity.y < 0:
			_animated_sprite.play("up_move")

		if velocity.x == 0 && velocity.y > 0:
			_animated_sprite.play("down_move")

		if velocity.x < 0:
			_animated_sprite.set_flip_h(false)
			_animated_sprite.play("side_move")

		if velocity.x > 0:
			_animated_sprite.set_flip_h(true)
			_animated_sprite.play("side_move")


func handle_collision(collision):
	var groups = collision.collider.get_groups()
	
	for group in groups:
		if group == 'enemy':
			get_tree().change_scene("res://scenes/Combat/Combat_Main.tscn")
		else:
			pass

func _physics_process(delta):
	read_input(delta)
