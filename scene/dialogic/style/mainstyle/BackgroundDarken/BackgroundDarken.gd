extends DialogicLayoutLayer

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_event)

func _on_dialogic_event(event: String):
	if event == "darken_bg":
		self.self_modulate = Color(1,1,1,1)
	if event == "lighten_bg":
		self.self_modulate = Color(1,1,1,0)
