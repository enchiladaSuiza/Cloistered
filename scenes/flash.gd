extends AnimatedSprite2D

var drop_scene: PackedScene:
	get():
		return drop_scene
	set(value):
		drop_scene = value

func _ready():
	self.play("default")

func _on_animation_finished():
	if drop_scene:
		var drop = drop_scene.instantiate()
		drop.position = self.position
		get_parent().call_deferred("add_child", drop)
	queue_free()
