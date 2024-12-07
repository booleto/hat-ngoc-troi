extends ButtonAction
class_name MultiAction

@export var actions: Array[ButtonAction]

func execute() -> void:
	for act in actions:
		act.execute()
