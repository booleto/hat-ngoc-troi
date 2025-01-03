extends DialogicLayoutLayer
class_name PauseMenu

@onready var pause_panel: Container = %PauseMenuPanel
@onready var inventory_panel: Container = %InventoryPanel
@export var pausable: bool = true
@export var inventory_openable: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_audio()
	UiEventBus.toggle_pause.connect(_on_toggle_pause)
	UiEventBus.toggle_inventory.connect(_on_toggle_inventory)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_cancel") and pausable:
		UiEventBus.toggle_pause.emit()
	if Input.is_action_just_released("ui_focus_next") and inventory_openable:
		UiEventBus.toggle_inventory.emit()
	
	# Skip feature, triggerd by pressing P
	_handle_pause()
		
		
func _handle_pause():
	if Input.is_action_just_released("dialogic_skip") and Dialogic.current_timeline != null and not Dialogic.Inputs.auto_skip.enabled:
		print_debug("setting autoskip true")
		Dialogic.Inputs.auto_skip.enabled = true
		return
	if Input.is_action_just_released("dialogic_skip") and Dialogic.Inputs.auto_skip.enabled:
		print_debug("setting autoskip false")
		Dialogic.Inputs.auto_skip.enabled = false
		return


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
