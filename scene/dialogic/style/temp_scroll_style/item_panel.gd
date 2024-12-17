extends DialogicLayoutLayer

@onready var item_scroll = %ItemScroll
@onready var rock_view = %RockView
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_event)

func _on_event(event: String):
	if event == "show_scroll":
		item_scroll.show()
	if event == "hide_scroll":
		item_scroll.hide()
	
	if event == "show_rock":
		rock_view.show()
	if event == "hide_rock":
		rock_view.hide()
