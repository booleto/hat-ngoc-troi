extends Node2D

var animation_counter: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('dialogic_default_action'):
		animation_counter += 1
	if animation_counter == 1:
		$AnimationPlayer.play("A10")
		animation_counter += 1
	if animation_counter == 3:
		$AnimationPlayer.play("Bb-16")
		animation_counter += 1
	if animation_counter == 5:
		$AnimationPlayer.play("Bb-17")
		animation_counter += 1
	if animation_counter == 7:
		$AnimationPlayer.play("End")
		animation_counter += 1
	if animation_counter == 9:
		LevelLoader.load_level_from_name("CG8")
