extends ButtonAction
class_name CameraMoveAction

@export var direction: Vector2

func execute():
	GameEventBus.move_camera.emit(direction)
