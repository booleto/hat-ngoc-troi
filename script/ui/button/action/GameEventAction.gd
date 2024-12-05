extends ButtonAction
class_name GameEventAction

enum EVENT {
	PLAY_ANIMATION, GAME_EVENT
}

@export var event_name: String
@export var event_type: EVENT

func execute() -> void:
	if event_type == EVENT.PLAY_ANIMATION:
		GameEventBus.play_animation.emit(event_name)
	if event_type == EVENT.GAME_EVENT:
		GameEventBus.game_event.emit(event_name)
