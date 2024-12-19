extends DialogicLayoutLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_event)


func _on_event(event: String):
	pass
