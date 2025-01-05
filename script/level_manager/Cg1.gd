extends Node2D

var animation_counter: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalMusicPlayer.play_music(GlobalMusicPlayer.SONG.PROLOGUE)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('dialogic_default_action'):
		animation_counter += 1
	if animation_counter == 1:
		$Segaydaden/Label.scale = Vector2.ZERO
		$Segaydaden/Label.visible = true
		$AnimationPlayer.play("A1")
		animation_counter += 1
	if animation_counter == 3:
		$AnimationPlayer.play("A2")
		animation_counter += 1
	if animation_counter == 5:
		$AnimationPlayer.play("Bb-01")
		animation_counter += 1
	if animation_counter == 7:
		LevelLoader.load_level_from_name("CG2")
