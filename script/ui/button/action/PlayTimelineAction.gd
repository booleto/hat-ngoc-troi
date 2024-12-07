extends ButtonAction
class_name PlayTimelineAction

@export var timeline : String

func execute() -> void:
	Dialogic.start(timeline)
