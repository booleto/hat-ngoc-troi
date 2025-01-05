extends Node2D
class_name LeafMark

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var center_vec: Vector2
var radius: float
var speed: float
var rad_position: float = 0.0

func initialize(start_point: Vector2, end_point: Vector2, speed: float):
	self.center_vec = (start_point + end_point) / 2
	self.radius = (start_point.x - end_point.x) / 2
	self.speed = speed
	self.rad_position = 0
	

func terminate_leaf():
	speed = 0
	animation_player.play("destroy_leaf")
	

func _process(delta: float) -> void:
	rad_position += speed * delta
	position.x = center_vec.x + radius * cos(rad_position)
