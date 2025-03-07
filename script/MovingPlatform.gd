extends CharacterBody2D

@export var start_pos: Vector2
@export var end_pos: Vector2
@export var speed: float = 7000.0

var direction: int = 1

func _physics_process(delta):
	var target: Vector2
	if direction == 1:
		target = end_pos
	else:
		target = start_pos
	var movement = (target - global_position).normalized() * speed * delta
	velocity = movement
	move_and_slide()

	if global_position.distance_to(target) < 5:
		if direction == 1:
			direction = -1
		else:
			direction = 1
