extends CharacterBody2D

class_name Player

signal hp_changed(value)
signal max_hp_changed(value)
signal coordinates_changed(coords: Vector2)
signal inventory_updated(inventory: Array)
signal item_got(item_name: String)

@export var speed: float = 8500.0
@export var hp: float = 10:
	get():
		return hp
	set(value):
		hp = value
		hp_changed.emit(hp)
@export var max_hp: float = 10:
	get():
		return max_hp
	set(value):
		max_hp = value
		max_hp_changed.emit(max_hp)

var moving_direction: Vector2
var firing_direction: Vector2
var last_moving_direction: Vector2 = Vector2(0, 1)
var can_fire: bool = true
var invincible: bool = false
var immediate_interactable: Interactable
var speed_modifier: float = 1.0: # Set by world
	get(): 
		return speed_modifier
	set(value):
		speed_modifier = value
var current_floor: int = 0:
	get():
		return current_floor
	set(value):
		current_floor = value

var pellet_scene := preload("res://scenes/pellet.tscn")

var inventory = []

func _ready():
	inventory_updated.emit(inventory)

func _physics_process(delta):
	moving_direction = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down")
	update_player_animation()
	
	firing_direction = Input.get_vector(
		"attack_left", "attack_right", "attack_up", "attack_down")
	handle_firing()
	update_slingshot_animation()
	
	if speed_modifier == 0:
		self.velocity = moving_direction * speed * delta
	else:
		self.velocity = moving_direction * speed * delta * speed_modifier
	move_and_slide()
	#if moving_direction:
		#coordinates_changed.emit(self.position)
		#print(self.position)

func _input(event):
	if event.is_action_pressed("interact"):
		if immediate_interactable:
			immediate_interactable.interact(inventory)
			if immediate_interactable.consumable_item:
				inventory.erase(immediate_interactable.consumable_item)
				inventory_updated.emit(inventory)

func update_player_animation():
	var direction: Vector2
	var animation_name: String
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

func handle_firing():
	if not can_fire or not firing_direction:
		return
	var pellet = pellet_scene.instantiate()
	pellet.ignore_area($Hurtbox)
	$Hurtbox.add_area_to_ignore(pellet.damagebox)
	pellet.position = self.position
	pellet.direction = firing_direction
	pellet.current_floor = current_floor
	can_fire = false
	$FiringTimer.start()
	#self.add_child(pellet)
	get_parent().add_child(pellet)
	
# URDL (Binary number): [Animation Name, X Offset, Y Offset, Flip, Tree Index]
var slingshot_animation_data = {
	1: ["side", -5, 0, false, 1],  # Left
	2: ["front", 0, 3, false, 1], # Down
	3: ["diagonal", -3, 3, true, 1], # DownLeft
	4: ["side", 5, 0, false, 1], # Right
	6: ["diagonal", 3, 3, false, 1], # DownRight
	8: ["front", 0, -3, false, 0], # Up
	9: ["diagonal", -3, -3, false, 0], # UpLeft
	12: ["diagonal", 3, -3, true, 0] # UpRight
}

func update_slingshot_animation():
	var index = 0
	if firing_direction.x > 0:
		index += 4
	elif firing_direction.x < 0:
		index += 1
	if firing_direction.y > 0:
		index += 2
	elif firing_direction.y < 0:
		index += 8
	var data = slingshot_animation_data.get(index)
	if data:
		$SlingshotSprites.visible = true
		$SlingshotSprites.play(data[0])
		$SlingshotSprites.offset = Vector2(data[1], data[2])
		$SlingshotSprites.flip_h = data[3]
		self.move_child($SlingshotSprites, data[4])
	else:
		$SlingshotSprites.visible = false
	
func _on_firing_timer_timeout():
	can_fire = true

func _on_hurtbox_damage_taken(value):
	if invincible:
		return
	$Animations.modulate = Color.RED
	$HurtTimer.start()
	invincible = true
	hp -= value
	hp_changed.emit(hp)
	if hp <= 0:
		die()

func _on_hurt_timer_timeout():
	$Animations.modulate = Color.WHITE
	invincible = false

func die():
	pass

func _on_interaction_area_area_entered(area):
	if area is Interactable:
		immediate_interactable = area
	elif area is Collectible:
		give_item(area.collectible)
		area.get_parent().queue_free()
		
func set_camera_limits(left, top, right, bottom):
	$Camera.limit_left = left
	$Camera.limit_top = top
	$Camera.limit_right = right
	$Camera.limit_bottom = bottom

func _on_interaction_area_area_exited(area):
	if area == immediate_interactable:
		immediate_interactable = null

func give_item(item):
	inventory.append(item)
	item_got.emit(item)
	inventory_updated.emit(inventory)
