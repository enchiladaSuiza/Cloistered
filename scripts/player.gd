extends CharacterBody2D

@export var speed: float = 10000.0

var current_direction: Vector2
var last_direction: Vector2 = Vector2(0, 1)
var animation_name: String

func _physics_process(delta):
	current_direction = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down")
	update_animation()
	
	self.velocity = current_direction * speed * delta
	move_and_slide()

func update_animation():
	var x: int
	var y: int
	if current_direction:
		x = current_direction.x as int
		y = current_direction.y as int
		var horizontal_name = ""
		var vertical_name = ""
		if x != 0:
			horizontal_name = "side"
		if y > 0:
			vertical_name = "down"
		elif y < 0:
			vertical_name = "up"
		animation_name = "walking_" + horizontal_name + vertical_name
		last_direction = current_direction
		$Animations.flip_h = current_direction.x < 0
	else:
		x = last_direction.x as int
		y = last_direction.y as int
		var horizontal_name = ""
		var vertical_name = ""
		if x != 0:
			horizontal_name = "side"
		if y > 0:
			vertical_name = "down"
		elif y < 0:
			vertical_name = "up"
		animation_name = "idle_" + horizontal_name + vertical_name
	$Animations.play(animation_name)
