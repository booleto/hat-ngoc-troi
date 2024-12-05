extends Node2D

var valid_events: Array[String] = [
	"rua_lan_left", "rua_lan_right", "rua_door"
]

var _doors_press: int = 0
var lan_left: bool = false
var lan_right: bool = false

func _ready() -> void:
	GameEventBus.game_event.connect(_on_game_event)
	Dialogic.start("rua_start")
	
	
func _preload_timelines():
	load("res://scene/dialogic/style/mainstyle/mainstyle.tres").prepare()
	Dialogic.preload_timeline("rua_start")
	Dialogic.preload_timeline("rua_door_1")
	Dialogic.preload_timeline("rua_door_2")
	Dialogic.preload_timeline("rua_door_3")
	Dialogic.preload_timeline("rua_lan_1")
	Dialogic.preload_timeline("rua_door_open")
	
	
func _on_game_event(event_name: String):
	print("Received event: ", event_name)
	assert(event_name in valid_events, "Invalid event: " + event_name)
	
	if (event_name == "rua_lan_left" or event_name == "rua_lan_right") and not (lan_left or lan_right):
		Dialogic.start("rua_lan_1")
	if event_name == "rua_lan_left":
		if not lan_left: GameEventBus.play_animation.emit("move_lan_left")
		lan_left = true
	if event_name == "rua_lan_right":
		if not lan_right: GameEventBus.play_animation.emit("move_lan_right")
		lan_right = true

		
	if event_name == "rua_door" and (lan_left and lan_right):
		GameEventBus.play_animation.emit("open_door")
		Dialogic.start("rua_door_open")
	
	if event_name == "rua_door":
		if _doors_press <= 0:
			Dialogic.start("rua_door_1")
		elif _doors_press == 1:
			Dialogic.start("rua_door_2")
		elif _doors_press >= 2:
			Dialogic.start("rua_door_3")
		_doors_press += 1
		return
