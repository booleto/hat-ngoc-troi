extends DialogicLayoutLayer
class_name PauseMenu

@export var pause_panel: Container
@export var inventory_panel: Container


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_audio()
	UiEventBus.toggle_pause.connect(_on_toggle_pause)
	UiEventBus.toggle_inventory.connect(_on_toggle_inventory)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		UiEventBus.toggle_pause.emit()
	if Input.is_action_just_released("ui_focus_next"):
		UiEventBus.toggle_inventory.emit()


func _on_toggle_pause():
	if pause_panel.visible:
		turn_off_pause()
		Dialogic.paused = false
	else:
		Dialogic.paused = true
		turn_on_pause()
		if inventory_panel.visible:
			turn_off_inventory()


func _on_toggle_inventory():
	if inventory_panel.visible:
		turn_off_inventory()
		Dialogic.paused = false
	else:
		Dialogic.paused = true
		turn_on_inventory()
		if pause_panel.visible:
			turn_off_pause()


func turn_on_pause():
	pause_panel.show()
	
func turn_off_pause():
	pause_panel.hide()

func turn_on_inventory():
	inventory_panel.show()
	
func turn_off_inventory():
	inventory_panel.hide()

func init_audio():
	Dialogic.Audio.base_music_player.bus = "Music"
	Dialogic.Audio.base_music_player.process_mode = Node.PROCESS_MODE_ALWAYS

	Dialogic.Audio.base_sound_player.bus = "SFX"
