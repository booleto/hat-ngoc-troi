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
		$AnimationPlayer.play("A7")
		animation_counter += 1
	if animation_counter == 3:
		$AnimationPlayer.play("Bb-09")
		animation_counter += 1
	if animation_counter == 5:
		$AnimationPlayer.play("Bb-10")
		animation_counter += 1
	if animation_counter == 7:
		$AnimationPlayer.play("Bb-11")
		animation_counter += 1
	if animation_counter == 9:
		$AnimationPlayer.play("Bb-12")
		animation_counter += 1
	if animation_counter == 11:
		$AnimationPlayer.play("Bb-13")
		animation_counter += 1
	if animation_counter == 13:
		LevelLoader.load_level_from_name("CG6")
