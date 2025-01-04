extends Node
class_name TimingGameManager

@onready var leaf_scene: PackedScene = preload("res://scene/minigame/tea_brew/LeafMark.tscn")
@onready var rating_bar: Control = %RatingBar

@export var start_point: Marker2D
@export var end_point: Marker2D
@export var success_area: Area2D

var is_playing: bool = false
var current_leaf: LeafMark

enum RATING {
	PASS, MISS
}

func _process(delta: float) -> void:
	if not is_playing:
		return
	if Input.is_action_just_pressed("ui_select"):
		var rating: RATING = rate_timing()
		if rating == RATING.PASS:
			GameEventBus.game_event.emit("tea_timing_passed")
	

func start_timing_game(speed: float):
	is_playing = true
	rating_bar.show()
	await get_tree().create_timer(0.2).timeout
	spawn_leaf(speed)
	pass
	
	
func end_timing_game():
	current_leaf.terminate_leaf()
	current_leaf = null
	rating_bar.hide()
	pass


func spawn_leaf(speed: float):
	var leaf: LeafMark = leaf_scene.instantiate()
	leaf.initialize(start_point.global_position, end_point.global_position, speed)
	add_sibling(leaf)
	current_leaf = leaf
	pass


func rate_timing() -> RATING:
	var is_fail = success_area.get_overlapping_bodies().filter(
		func(leaf: Node2D): return leaf is LeafMark
	).is_empty()
	
	if is_fail:
		return RATING.MISS
	else:
		return RATING.PASS
