extends Node2D
class_name ThanhDiaTuLinh

var found_door: bool = false

func _ready() -> void:
	GameEventBus.play_animation.emit("arrows")
	Dialogic.start("tdtl_start")
	GameEventBus.game_event.connect(_on_game_event)
	Dialogic.signal_event.connect(_on_game_event)

func _on_game_event(event: String):
	if event == "door_tu" and not found_door:
		Dialogic.start("tdtl_correct_door")
		found_door = true
	if event == "door_tu" and found_door:
		Dialogic.start("tdtl_correct_door_short")
	
