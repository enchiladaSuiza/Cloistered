extends CharacterBody2D

@export var speed: float = 10000.0

var direction: Vector2

func _physics_process(delta):
	direction = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * speed * delta
	move_and_slide()
