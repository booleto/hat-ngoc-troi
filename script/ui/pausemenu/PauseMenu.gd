extends DialogicLayoutLayer
class_name PauseMenu

@export var show_pause_button: bool = true
@export var show_inventory_button: bool = true

@onready var pause_button: ButtonBase = %PauseButton
@onready var inventory_button: ButtonBase = %InventoryButton

@export var pausable: bool = true
@export var inventory_openable: bool = true

@onready var pause_panel: Container = %PauseMenuPanel
@onready var inventory_panel: Container = %InventoryPanel
@onready var game_exit_panel: Container = %GameExitPanel

@onready var graphics_scale: Container = %GraphicsScale
@onready var sfx_scale: Container = %SFXVolune
@onready var music_scale: Container = %MusicVolune

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_audio()
	UiEventBus.toggle_pause.connect(_on_toggle_pause)
	UiEventBus.toggle_inventory.connect(_on_toggle_inventory)
	UiEventBus.view_graphics_settings.connect(view_graphics_settings)
	UiEventBus.view_sound_settings.connect(view_sound_settings)
	UiEventBus.exit_game.connect(_on_exit_game_request)
	UiEventBus.exit_game_confirm.connect(_on_exit_game_confirm)
	UiEventBus.exit_game_cancel.connect(_on_exit_game_cancel)
	
	await get_parent().ready
	if show_pause_button:
		pause_button.show()
	if show_inventory_button:
		inventory_button.show()
	


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
		#Dialogic.paused = false
	else:
		#Dialogic.paused = true
		turn_on_pause()
		if inventory_panel.visible:
			turn_off_inventory()


func _on_toggle_inventory():
	if inventory_panel.visible:
		turn_off_inventory()
		#Dialogic.paused = false
	else:
		#Dialogic.paused = true
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
	
func view_graphics_settings():
	graphics_scale.show()
	sfx_scale.hide()
	music_scale.hide()
	pass

func view_sound_settings():
	graphics_scale.hide()
	sfx_scale.show()
	music_scale.show()
	pass

func init_audio():
	Dialogic.Audio.base_music_player.bus = "Music"
	Dialogic.Audio.base_music_player.process_mode = Node.PROCESS_MODE_ALWAYS

	Dialogic.Audio.base_sound_player.bus = "SFX"

func _on_exit_game_request():
	game_exit_panel.show()
	pass
	
func _on_exit_game_cancel():
	game_exit_panel.hide()
	pass
	
func _on_exit_game_confirm():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
	pass
