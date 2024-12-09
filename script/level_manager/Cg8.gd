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
		$AnimationPlayer.play("Bb-21")
		animation_counter += 1
	if animation_counter == 3:
		$AnimationPlayer.play("B1")
		animation_counter += 1
	if animation_counter == 5:
		$AnimationPlayer.play("Bb-18")
		animation_counter += 1
	if animation_counter == 7:
		$AnimationPlayer.play("B2")
		animation_counter += 1
	if animation_counter == 9:
		$AnimationPlayer.play("Bb-19")
		animation_counter += 1
	if animation_counter == 11:
		$AnimationPlayer.play("Cc-02")
		animation_counter += 1
	if animation_counter == 13:
		LevelLoader.load_level_from_name("CG9")
