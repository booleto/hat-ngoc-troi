extends BaseButton
class_name ButtonBase

@export var action : ButtonAction
@export var delete_on_use: bool

func _ready() -> void:
	assert(action != null, "This button has no action assigned to it!")
	assert(self is BaseButton, "Button script assigned to something that's not a button!")
	self.button_up.connect(_on_trigger)

func _on_trigger() -> void:
	action.execute()
	if delete_on_use:
		queue_free()
