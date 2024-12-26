extends BaseButton
class_name ButtonBase

@export var action : ButtonAction
@export var delete_on_use: bool
@onready var glow_obj: Container = $CenterContainer

func _ready() -> void:
	assert(action != null, "This button has no action assigned to it!")
	assert(self is BaseButton, "Button script assigned to something that's not a button!")
	self.button_up.connect(_on_trigger)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

func _on_trigger() -> void:
	action.execute()
	if delete_on_use:
		queue_free()
	

func _on_mouse_entered():
	if self.is_in_group("main_menu_buttons"):
		$Label.label_settings.font_color = Color.SADDLE_BROWN
	elif self.is_in_group("den_phuong_buttons"):
		glow_obj.visible = true


func _on_mouse_exited():
	if self.is_in_group("main_menu_buttons"):
		$Label.label_settings.font_color = Color.WHITE
	elif self.is_in_group("den_phuong_buttons"):
		glow_obj.visible = false
