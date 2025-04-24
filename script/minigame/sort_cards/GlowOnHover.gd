extends TextureRect

@onready var glow_obj: Container = $CenterContainer

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exit)

func _on_mouse_entered() -> void:
	glow_obj.visible = true
	print("on")
	
func _on_mouse_exit() -> void:
	glow_obj.visible = false
	print("off")
