extends Node

@onready var item_panel: PanelContainer = %ItemPanel
var walked: bool = false
var walk_can_start: bool = false

func _ready() -> void:
	#GameEventBus.play_animation.emit("cloud_sway")
	#GameEventBus.play_animation.emit("walk_forward")
	Dialogic.start("chiem_bao_start")
	GameEventBus.game_event.connect(_on_game_event)
	Dialogic.signal_event.connect(_on_game_event)
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select") and walk_can_start:
		GameEventBus.play_animation.emit("walk_forward")
	
	if Input.is_action_just_released("ui_select") and walk_can_start:
		GameEventBus.play_animation.emit("pause_animation")
		

func _on_game_event(event: String):
	print("Received event: ", event)
	if event == "walk_can_start":
		walk_can_start = true
		print("Walk sequence can start")
	
	if event == "walk_finish":
		#await get_tree().create_timer(3.0).timeout
		walk_can_start = false
		print("starting")
		Dialogic.start("chiem_bao_walk_finish")
	if event == "touch_statue":
			Dialogic.start("chiem_bao")
			
	if event == "show_scroll":
		item_panel.show()
	
	if event == "hide_scroll":
		item_panel.hide()
