extends ButtonBase
class_name ButtonHold

@export var on_press: ButtonAction
@export var on_release: ButtonAction

func _ready() -> void:
	assert(action != null, "This button has no action assigned to it!")
	assert(self is BaseButton, "Button script assigned to something that's not a button!")
	self.button_down.connect(press)
	self.button_up.connect(release)
	
func press():
	on_press.execute()
	
func release():
	on_release.execute()
