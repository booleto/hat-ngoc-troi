extends Node

@onready var statue_right_panel : PanelContainer = %StatueRightPanel
@onready var statue_left_panel : PanelContainer = %StatueLeftPanel

func _ready() -> void:
	GameEventBus.play_animation.emit("arrows")
	Dialogic.signal_event.connect(_on_game_event)
	GameEventBus.game_event.connect(_on_game_event)
	
func _on_game_event(event: String):
	print_debug("Received Event: ", event)
	
	if event == "view_statue_right":
		statue_right_panel.show()
	if event == "hide_statue_right":
		statue_right_panel.hide()
	if event == "view_statue_left":
		statue_left_panel.show()
	if event == "hide_statue_left":
		statue_left_panel.hide()
		
	
	pass
