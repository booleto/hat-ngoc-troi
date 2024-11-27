extends Slider
class_name LiveSlider

@export var default_value: float
@export var action: SliderAction

func _ready() -> void:
	self.value_changed.connect(_on_slider_changed)
	self.value = default_value
		
func _on_slider_changed(val: float):
	print(val)
	action.execute(val)
