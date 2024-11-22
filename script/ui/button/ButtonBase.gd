extends Button
class_name ButtonBase

@export var action : ButtonAction

func _ready() -> void:
	assert(action != null, "This button has no action assigned to it!")
	assert(self is Button, "Button script assigned to something that's not a button!")
	self.button_up.connect(_on_trigger)

func _on_trigger() -> void:
	action.execute()
