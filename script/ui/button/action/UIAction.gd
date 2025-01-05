extends ButtonAction
class_name UIAction

enum ACTIONS {
	TOGGLE_PAUSE, TOGGLE_HISTORY, TOGGLE_INVENTORY, VIEW_SOUND_SETTINGS, VIEW_GRAPHICS_SETTINGS,
	EXIT_GAME, EXIT_GAME_CONFIRM, EXIT_GAME_CANCEL
}

@export var action_to_do: ACTIONS

func execute() -> void:
	match action_to_do:
		ACTIONS.TOGGLE_PAUSE:
			UiEventBus.toggle_pause.emit()
			print("Pause toggled")
			
		ACTIONS.TOGGLE_HISTORY:
			UiEventBus.toggle_history.emit()
			print("History toggled")
			
		ACTIONS.TOGGLE_INVENTORY:
			UiEventBus.toggle_inventory.emit()
			print("Inventory toggled")
		
		ACTIONS.VIEW_SOUND_SETTINGS:
			UiEventBus.view_sound_settings.emit()
			print("Viewed sound settings")
		
		ACTIONS.VIEW_GRAPHICS_SETTINGS:
			UiEventBus.view_graphics_settings.emit()
			print("Viewed sound settings")
		
		ACTIONS.EXIT_GAME:
			UiEventBus.exit_game.emit()
			print("Viewed exit game panel")
		
		ACTIONS.EXIT_GAME_CANCEL:
			UiEventBus.exit_game_cancel.emit()
			print("Viewed exit game panel")
		
		ACTIONS.EXIT_GAME_CONFIRM:
			UiEventBus.exit_game_confirm.emit()
			print("Viewed exit game panel")
