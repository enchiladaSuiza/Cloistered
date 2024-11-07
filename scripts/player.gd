extends CharacterBody2D

@export var speed: float = 8500.0

var moving_direction: Vector2
var last_moving_direction: Vector2 = Vector2(0, 1)
var animation_name: String

var pellet_scene := preload("res://scenes/pellet.tscn")

func _physics_process(delta):
	moving_direction = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down")
	update_animation()
	
	var firing_direction = Input.get_vector(
		"attack_left", "attack_right", "attack_up", "attack_down")
	handle_firing(firing_direction)
	
	self.velocity = moving_direction * speed * delta
	move_and_slide()

func update_animation():
	var direction: Vector2
	if moving_direction:
		animation_name = "walking_"
		direction = moving_direction
		last_moving_direction = moving_direction
		$Animations.flip_h = moving_direction.x < 0
	else:
		animation_name = "idle_"
		direction = last_moving_direction
	if direction.x != 0:
		animation_name += "side"
	if direction.y > 0:
		animation_name += "down"
	elif direction.y < 0:
		animation_name += "up"

	$Animations.play(animation_name)

func handle_firing(direction):
	if not direction:
		return
	var pellet = pellet_scene.instantiate()
	pellet.position = self.position
	pellet.direction = direction
	get_parent().add_child(pellet)
