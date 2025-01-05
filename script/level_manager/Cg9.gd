extends Node2D

var animation_counter: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Segaydaden/B4.visible = false
	$Segaydaden/B5.visible = false
	$Segaydaden/B6.visible = false
	GlobalMusicPlayer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('dialogic_default_action'):
		animation_counter += 1
	if animation_counter == 1:
		$AnimationPlayer.play("B3")
		animation_counter += 1
	if animation_counter == 3:
		$AnimationPlayer.play("Cc-03")
		animation_counter += 1
	if animation_counter == 5:
		$AnimationPlayer.play("Bb-20")
		animation_counter += 1
	if animation_counter == 7:
		$AnimationPlayer.play("Eye Close")
		animation_counter += 1
	if animation_counter == 9:
		LevelLoader.load_level_from_name("CHIEM_BAO_MAY")
