extends Node2D
class_name DrumMinigame

@export var DEBUG: bool = false
@export var arrow_packed: PackedScene
@export var travel_time: float
@export var music_sheet: MusicSheet
@export var min_score: int = 50

@onready var spawn_point: Marker2D = %ArrowSpawn
@onready var end_point: Marker2D = %ArrowEnd
@onready var bad_area: Area2D = %BadArea
@onready var okay_area: Area2D = %OkayArea
@onready var perfect_area: Area2D = %PerfectArea
@onready var rating_label: RatingLabel = %RatingLabel
@onready var red_stick_sprite: AnimatedSprite2D = %RedStick
@onready var blue_stick_sprite: AnimatedSprite2D = %BlueStick
@onready var progress_bar: TextureProgressBar = %ProgressBar

@onready var sfx_player: AudioStreamPlayer = %SFXPlayer
@onready var music_player: AudioStreamPlayer = %MusicPlayer

@onready var combo_num: Label = %ComboNum
@onready var score_num: Label = %ScoreNum

var game_started: bool = false
var song_ending: bool = false
var perfects: int = 0
var okays: int = 0
var bads: int = 0
var misses: int = 0
var combo: int = 0
var song_position: int = 0
var red_stick: bool = true
var blue_stick: bool = false

enum RATING {
	MISS, BAD, OK, PERFECT
}


func _ready() -> void:
	progress_bar.max_value = min_score
	GameEventBus.play_animation.emit("grass_sway")
	GameEventBus.play_animation.emit("grass_growth")
	GameEventBus.play_animation.emit("start_stage")
	GameEventBus.game_event.connect(_on_game_event)
	GlobalMusicPlayer.stop()
	start_minigame()


func _on_game_event(event: String):
	if event == "note_missed":
		pass


func _process(delta: float) -> void:
	if game_started:
		_process_rhythm_input(delta)


func _physics_process(delta: float) -> void:
	if game_started and not song_ending:
		_process_song(delta)


func start_minigame():
	game_started = true
	song_ending = false
	song_position = 0
	perfects = 0
	okays = 0
	bads = 0
	misses = 0
	combo = 0
	update_score()
	update_progress()
	music_player.play()
	

func end_minigame():
	game_started = false
	if evaluate_result():
		GameEventBus.play_animation.emit("mission_completed")
		await get_tree().create_timer(3.0).timeout
		LevelLoader.load_level(LevelLoader.LEVEL.DEN_PHUONG_SAU_MINIGAME)
	else:
		GameEventBus.play_animation.emit("mission_failed")
		await get_tree().create_timer(3.0).timeout
		LevelLoader.load_level(LevelLoader.LEVEL.DRUM_MINIGAME)
		

func evaluate_result() -> bool:
	if okays + perfects + bads > min_score:
		return true
	else:
		return false

func _process_song(delta: float) -> void:
	var time: float = music_player.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	var beat: float = (time - music_sheet.offset - travel_time) * music_sheet.bpm * music_sheet.bar_beats / 60.0
	if song_position >= music_sheet.sheet.size():
		song_ending = true
		await get_tree().create_timer(travel_time + 3.0).timeout
		end_minigame()
		
	for i in range(song_position, music_sheet.sheet.size()):
		var note: Note = music_sheet.sheet[i]
		if note.timestamp <= beat:
			print("Spawn note ", note.direction, " on beat ", beat)
			spawn_arrow(note)
			song_position += 1
			#music_sheet.sheet.pop_front()
		else:
			break


func _process_rhythm_input(delta: float) -> void:
	var key: Arrow.DIR = Arrow.DIR.NIL
	if Input.is_action_just_pressed("ui_up"):
		key = Arrow.DIR.UP
	if Input.is_action_just_pressed("ui_down"):
		key = Arrow.DIR.DOWN
	if Input.is_action_just_pressed("ui_left"):
		key = Arrow.DIR.LEFT
	if Input.is_action_just_pressed("ui_right"):
		key = Arrow.DIR.RIGHT
	if key == Arrow.DIR.NIL:
		return
	
	GameEventBus.play_animation.emit("drum_hit")
	sfx_player.play()
	update_stick_sprite()
	var arrow: Arrow = get_latest_arrow()
	if arrow == null:
		_on_miss()
		return
	
	if not key == arrow.dir:
		_on_miss()
		despawn_arrow(arrow, RATING.MISS)
		return
	var rating: RATING = rate_arrow(arrow)
	
	match rating:
		RATING.MISS:
			_on_miss()
		RATING.BAD:
			_on_bad()
		RATING.OK:
			_on_okay()
		RATING.PERFECT:
			_on_perfect()
		_:
			print("Unknown grade")
		
	despawn_arrow(arrow, rating)


func despawn_arrow(arrow: Arrow, rating: RATING):
	arrow.finish(rating)


func spawn_arrow(note: Note):
	var arrow: Arrow = arrow_packed.instantiate()
	add_child(arrow)
	arrow.set_target(spawn_point.position, end_point.position, travel_time)
	arrow.set_direction(note.direction)
	if DEBUG:
		arrow.get_child(3).text = str(note.timestamp)
	pass


func get_latest_arrow() -> Arrow:
	var bodies: Array = bad_area.get_overlapping_bodies().filter(_is_arrow)
	if bodies.size() == 0:
		return
	var body: Arrow = bodies[0]
	for b: Arrow in bodies:
		if b.position.x > body.position.x:
			body = b
	
	return body
	

func _on_deletion_area_entered(body):
	if body is Arrow:
		body.finish(RATING.MISS)
		_on_miss()


func rate_arrow(arrow: Arrow) -> RATING:
	if not bad_area.get_overlapping_bodies().has(arrow):
		return RATING.MISS
	
	if not okay_area.get_overlapping_bodies().has(arrow):
		return RATING.BAD
	
	if not perfect_area.get_overlapping_bodies().has(arrow):
		return RATING.OK
	
	return RATING.PERFECT


func _is_arrow(obj: Node2D) -> bool:
	return obj is Arrow


func update_combo(rating: RATING) -> void:
	rating_label.update_rating(rating)
	if rating == RATING.MISS or rating == RATING.BAD:
		combo = 0
	else:
		combo += 1
	combo_num.text = str(combo)

func update_score() -> void:
	score_num.text = str((bads + okays + perfects)*100)

func update_progress() -> void:
	progress_bar.value = bads + okays + perfects

func _on_miss() -> void:
	print("Miss")
	misses += 1
	update_score()
	update_progress()
	update_combo(RATING.MISS)

func _on_bad() -> void:
	print("Bad")
	okays += 1
	update_score()
	update_progress()
	update_combo(RATING.BAD)
	
func _on_okay() -> void:
	print("Okay")
	okays += 1
	update_score()
	update_progress()
	update_combo(RATING.OK)

func _on_perfect() -> void:
	print("Perfect")
	perfects += 1
	update_score()
	update_progress()
	update_combo(RATING.PERFECT)

func update_stick_sprite():
	if red_stick:
		red_stick = false
		blue_stick = true
		red_stick_sprite.play()
		$Background/RedStick/AnimationPlayer.play("red_effect")
		#await red_stick_sprite.animation_finished
		#red_stick_sprite.set_frame(0)
	elif blue_stick:
		blue_stick = false
		red_stick = true
		blue_stick_sprite.play()
		$Background/BlueStick/AnimationPlayer.play("blue_effect")
		#await blue_stick_sprite.animation_finished
		#blue_stick_sprite.set_frame(0)
