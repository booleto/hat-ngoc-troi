extends DialogicLayoutLayer
class_name MissionTab

@onready var label = %Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEventBus.game_event.connect(_on_game_event)
	Dialogic.signal_event.connect(_on_game_event)

# Update the mission tab when it's already added to the scene
func _on_game_event(event: String) -> void:
	print("MT Received Event: ", event)
	if event == "card_pressed":
		print(Dialogic.VAR.card_count)
		label.text = "Tìm các tấm thẻ gỗ (" + str(Dialogic.VAR.card_count) + "/6)"
	
