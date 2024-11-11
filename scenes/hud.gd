extends CanvasLayer

@export var player: Player

func _ready():
	player.hp_changed.connect(self.hp_changed)
	$LifeBar.max_value = player.max_hp
	$LifeBar.value = player.hp
	$LifeBar/LifeLabel.text = str(player.hp) + "/" + str(player.max_hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hp_changed(value: float):
	$LifeBar.value = value
	$LifeBar/LifeLabel.text = str(value) + "/" + str(player.max_hp)
