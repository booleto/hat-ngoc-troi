extends Control
class_name HoverTween

@export var tween_start: Vector2
@export var tween_end: Vector2
@export var actor: Node
@export var duration: float
@export var ease: Tween.EaseType

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_hover)
	self.mouse_exited.connect(_on_mouse_exited)
	actor.position = tween_start


func _on_mouse_hover():
	var tween = create_tween()
	tween.tween_property(actor, "position", tween_end, duration)
	tween.set_ease(ease)
	

func _on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(actor, "position", tween_start, duration)
	tween.set_ease(ease)
