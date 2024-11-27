extends SliderAction
class_name AudioSliderAction

@export var audio_bus: String

func execute(val: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(audio_bus),
		linear_to_db(val)
	)
	print("Bus: ", audio_bus, " with new val: ", str(val))
