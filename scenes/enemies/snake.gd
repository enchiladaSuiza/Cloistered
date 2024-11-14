extends CharacterBody2D

@export var hp: float = 3
@export var min_wait_time: int = 1
@export var max_wait_time: int = 3
@export var min_move_time: int = 1
@export var max_move_time: int = 3

var possible_directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
var direction: Vector2
var speed: float = 4000.0

var flash_scene = preload("res://scenes/flash.tscn")

func _ready() -> void:
	$Hurtbox.add_area_to_ignore($Damagebox)
	$Damagebox.add_area_to_ignore($Hurtbox)
	start_waiting()

func _process(delta: float) -> void:
	self.velocity = direction * speed * delta
	move_and_slide()

func die():
	var flash = flash_scene.instantiate()
	flash.position = self.position
	get_parent().add_child(flash)
	queue_free()

func _on_wait_timer_timeout() -> void:
	start_moving()

func _on_move_timer_timeout() -> void:
	start_waiting()

func start_waiting():
	direction = Vector2.ZERO
	$WaitTimer.wait_time = randi_range(min_wait_time, max_wait_time)
	$WaitTimer.start()

func start_moving():
	direction = possible_directions.pick_random()
	update_animation()
	$MoveTimer.wait_time = randi_range(min_wait_time, max_wait_time)
	$MoveTimer.start()

func update_animation():
	var animation_name: String
	var flip_h: bool = false
	if direction.x != 0:
		animation_name = "side"
		if direction.x < 0:
			flip_h = true
	if direction.y > 0:
		animation_name = "down"
	if direction.y < 0:
		animation_name = "up"
	$Animations.play(animation_name)
	$Animations.flip_h = flip_h
	
func _on_frame_timer_timeout() -> void:
	if not direction:
		return
	if direction.x != 0:
		$Animations.flip_v = !$Animations.flip_v
	if direction.y != 0:
		$Animations.flip_h = !$Animations.flip_h

func _on_damage_tint_timer_timeout() -> void:
	$Animations.modulate = Color.WHITE
	
func _on_hurtbox_damage_taken(damage):
	$Animations.modulate = Color.RED
	$DamageTintTimer.start()
	hp -= damage
	if hp <= 0:
		die()
		
