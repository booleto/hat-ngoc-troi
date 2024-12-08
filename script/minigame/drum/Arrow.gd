extends Node2D
class_name Arrow

enum DIR {
	UP, DOWN, LEFT, RIGHT, NIL
}

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var animation: AnimationPlayer = %AnimationPlayer
var target: Vector2
var time_left: float
var dir: DIR
var speed: Vector2


func set_direction(direction: DIR):
	self.dir = direction
	sprite.frame = dir
	

func set_target(start: Vector2, target: Vector2, travel_time: float):
	self.position = start
	self.target = target
	self.time_left = travel_time
	self.speed = (target - start) / travel_time

func _physics_process(delta: float) -> void:
	self.position += speed * delta
	time_left -= delta

func finish(rating: DrumMinigame.RATING):
	animation.play("finish")
