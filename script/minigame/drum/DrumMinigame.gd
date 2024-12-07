extends Node2D

@export var arrow_packed: PackedScene
@export var travel_time: float
@onready var spawn_point: Marker2D = %ArrowSpawn
@onready var end_point: Marker2D = %ArrowEnd
@onready var bad_area: Area2D = %BadArea
@onready var okay_area: Area2D = %OkayArea
@onready var perfect_area: Area2D = %PerfectArea

var game_started: bool = false
var perfects: int
var goods: int
var bads: int
var misses: int

enum RATING {
	MISS, BAD, OK, PERFECT
}

class Note:
	var timestamp: float
	var direction: Arrow.DIR
	
	func _init(t: float, d: Arrow.DIR) -> void:
		timestamp = t
		direction = d
	

func _ready() -> void:
	game_started = true
	spawn_arrow(Note.new(0, Arrow.DIR.UP))
	GameEventBus.game_event.connect(_on_game_event)


func _on_game_event(event: String):
	if event == "note_missed":
		pass


func _process(delta: float) -> void:
	if game_started:
		_process_rhythm_game(delta)


func _process_rhythm_game(delta: float) -> void:
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
		
	var arrow: Arrow = get_latest_arrow()
	if arrow == null:
		print("miss")
		return
	
	if not key == arrow.dir:
		print("miss")
		return
	var rating: RATING = rate_arrow(arrow)
	
	match rating:
		RATING.MISS:
			print("miss")
		RATING.OK:
			print("ok")
		RATING.PERFECT:
			print("perfect")
			

func spawn_arrow(note: Note):
	var arrow: Arrow = arrow_packed.instantiate()
	add_child(arrow)
	arrow.set_target(spawn_point.position, end_point.position, travel_time)
	arrow.set_direction(note.direction)
	pass


func get_latest_arrow() -> Arrow:
	var bodies: Array = bad_area.get_overlapping_bodies().filter(_is_arrow)
	if bodies.size() == 0:
		return
	var body: Arrow = bodies[0]
	for b: Arrow in bodies:
		if b.position.x < body.position.x:
			body = b
	
	return body
	
	
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
