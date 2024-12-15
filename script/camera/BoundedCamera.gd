extends Camera2D
class_name BoundedCamera

@export var speed_x: float
@export var speed_y: float
@export var upper_bound: Vector2 = Vector2.ZERO
@export var lower_bound: Vector2 = Vector2.ZERO

var speed_vec: Vector2
var stop_moving: bool = false
var event_vec: Vector2

func _ready():
	speed_vec = Vector2(speed_x, speed_y)
	GameEventBus.move_camera.connect(_handle_camera_event)

func _handle_camera_event(dir: Vector2):
	event_vec = dir

func _process(delta: float) -> void:
	if stop_moving:
		return
		
	var dir: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		dir += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		dir += Vector2(1, 0)
	if Input.is_action_pressed("ui_up"):
		dir += Vector2(0, 1)
	if Input.is_action_pressed("ui_down"):
		dir += Vector2(0, -1)
	dir += event_vec
	dir = sign_vec(dir)
	move_in_dir(dir, delta)
	

func move_in_dir(direction: Vector2, delta: float):
	position += direction.normalized() * speed_vec * delta
	position = position.clamp(lower_bound, upper_bound)

func sign_vec(vec: Vector2) -> Vector2:
	return Vector2(sign(vec.x), sign(vec.y))
