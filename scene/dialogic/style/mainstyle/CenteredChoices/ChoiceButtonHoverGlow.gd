extends DialogicNode_ChoiceButton

@export var viewport_default: ViewportTexture
@export var viewport_hover: ViewportTexture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.mouse_entered.connect(_glow)
	self.mouse_exited.connect(_unglow)


func _glow() -> void:
	self.icon = viewport_hover
	
func _unglow() -> void:
	self.icon = viewport_default
