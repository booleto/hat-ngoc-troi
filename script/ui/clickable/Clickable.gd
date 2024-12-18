extends Control

@export var arrow_sprite: TextureRect

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exit)
	
func _on_mouse_entered() -> void:
	arrow_sprite.show()
	
func _on_mouse_exit() -> void:
	arrow_sprite.hide()
