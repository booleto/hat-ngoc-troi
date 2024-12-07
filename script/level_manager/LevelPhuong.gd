extends Node2D

@onready var card_panel_scene = preload("res://scene/minigame/drag_cards/card_sort_panel.tscn")
@onready var main_panel = %MainPanel
var card_list: ReorderableContainer = null
var card_panel: CardSortPanel = null

const correct_order: Array[String] = [
	"LuaKho",
	"NuocCan",
	"AiOi",
	"RuNhau",
	"TatNuoc",
	"ChoTroi",
	"ConLau"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("cards_done")
	GameEventBus.game_event.connect(_on_game_event)
	Dialogic.signal_event.connect(_on_game_event)

func _on_game_event(event: String) -> void:
	print("Received Event: ", event)
	if event == "sort_start":
		start_sort_game()
		
	if event == "card_sorted":
		if is_cards_sorted():
			print("sorted")
			end_sort_game()
		else:
			print("not sorted")
			end_sort_game_fail()


func start_sort_game() -> void:
	card_panel = card_panel_scene.instantiate()
	main_panel.add_child(card_panel)
	card_panel.show()
	card_list = card_panel.get_card_list()
	pass


func end_sort_game_fail() -> void:
	card_list = null
	card_panel.queue_free()
	await card_panel.tree_exited
	card_panel = null
	Dialogic.start("cards_sort_fail")


func end_sort_game() -> void:
	card_list = null
	card_panel.queue_free()
	await card_panel.tree_exited
	card_panel = null
	Dialogic.start("cards_sorted")
	pass


func is_cards_sorted() -> bool:
	for i in range(correct_order.size()):
		if not card_list.get_child(i).name == correct_order[i]:
			return false
	return true
