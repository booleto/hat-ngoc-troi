extends DialogicLayoutLayer

@onready var item_scroll = %ItemScroll
@onready var item_seed = %ItemSeed
@onready var rock_view = %RockView
@onready var field_dry_view = %FieldDryView

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_event)

func _on_event(event: String):
	if event == "show_scroll":
		item_scroll.show()
	if event == "hide_scroll":
		item_scroll.hide()
		
	if event == "show_seed":
		item_seed.show()
	if event == "hide_seed":
		item_seed.hide()
	
	if event == "show_rock":
		rock_view.show()
	if event == "hide_rock":
		rock_view.hide()
	
	if event == "show_field_dry":
		field_dry_view.show()
	if event == "hide_field_dry":
		field_dry_view.hide()
