extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("sega_logo")
	GameEventBus.play_animation.emit("wheat_sway")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
