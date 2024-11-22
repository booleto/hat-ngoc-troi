extends ButtonAction
class_name UIAction

enum ACTIONS {
	TOGGLE_PAUSE, TOGGLE_HISTORY, TOGGLE_INVENTORY
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
