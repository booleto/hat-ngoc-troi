extends Label
class_name RatingLabel

@onready var rating_animation: AnimationPlayer = $RatingAnimation

var rating_display: Dictionary = {
	DrumMinigame.RATING.MISS: "Trượt\nrồi!",
	DrumMinigame.RATING.BAD: "Không\ntồi!",
	DrumMinigame.RATING.OK: "Tốt\nlắm!",
	DrumMinigame.RATING.PERFECT: "Hoàn\nhảo!"
}

var rating_color: Dictionary = {
	DrumMinigame.RATING.MISS: Color(0.878, 0.204, 0.204),
	DrumMinigame.RATING.BAD: Color(0.794, 0.484, 0.88),
	DrumMinigame.RATING.OK: Color(0.485, 0.88, 0.202),
	DrumMinigame.RATING.PERFECT: Color(1, 0.744, 0.27)
}

func update_rating(rating: DrumMinigame.RATING):
	text = rating_display.get(rating)
	label_settings.shadow_color = rating_color.get(rating)
	if rating_animation.is_playing():
		rating_animation.stop()
	rating_animation.play("new_rating")
