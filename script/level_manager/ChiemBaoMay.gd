extends Node

var walked: bool = false

func _ready() -> void:
	#GameEventBus.play_animation.emit("cloud_sway")
	#GameEventBus.play_animation.emit("walk_forward")
	Dialogic.start("chiem_bao_start")
	GameEventBus.game_event.connect(_on_game_event)
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_select") and not walked:
		walked = true
		GameEventBus.play_animation.emit("walk_forward")

func _on_game_event(event: String):
	print("Received event: ", event)
	if event == "walk_finish":
		#await get_tree().create_timer(3.0).timeout
		print("starting")
		Dialogic.start("chiem_bao_walk_finish")
	if event == "touch_statue":
			Dialogic.start("chiem_bao")
