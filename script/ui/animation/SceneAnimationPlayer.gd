extends AnimationPlayer
class_name SceneAnimationPlayer

func _ready() -> void:
	GameEventBus.play_animation.connect(_on_animation_request)
	
	
func _on_animation_request(animation: String):
	if animation == "pause_animation":
		self.pause()
	if animation == "resume_animation":
		self.play()
		
	if self.has_animation(animation):
		self.play(animation)
	else:
		print("This scene's animation player does not have the animation " + animation)
