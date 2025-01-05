extends Node2D

@onready var card_panel_scene = preload("res://scene/minigame/drag_cards/card_sort_panel.tscn")
@onready var mission_tab_scene = preload("res://scene/dialogic/style/mainstyle/MissionTab/mission_tab.tscn")
@onready var main_panel = %MainPanel
var card_list: ReorderableContainer = null
var card_panel: CardSortPanel = null
var mission_tab: MissionTab = null

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
	Dialogic.start("mieu_phuong_start")
	GameEventBus.game_event.connect(_on_game_event)
	Dialogic.signal_event.connect(_on_game_event)
	GlobalMusicPlayer.stop()
	GlobalMusicPlayer.play_music(GlobalMusicPlayer.SONG.DEN_PHUONG)

func _on_game_event(event: String) -> void:
	print("Received Event: ", event)
	if event == "find_card_start":
		start_find_card_game()
	
	if event == "find_card_done":
		end_find_card_game()
	
	if event == "sort_start":
		start_sort_game()
		
	if event == "card_sorted":
		if is_cards_sorted():
			print("sorted")
			end_sort_game()
		else:
			print("not sorted")
			end_sort_game_fail()


# Add the mission tab when the find card minigame start
func start_find_card_game() -> void:
	mission_tab = mission_tab_scene.instantiate()
	main_panel.add_child(mission_tab)
	mission_tab.label.text = "Tìm các tấm thẻ gỗ (" + str(Dialogic.VAR.card_count) + "/6)"
	
# Delet the mission tab when the find card minigame start
func end_find_card_game() -> void:
	mission_tab.queue_free()
	await mission_tab.tree_exited
	mission_tab = null

func start_sort_game() -> void:
	mission_tab = mission_tab_scene.instantiate()
	main_panel.add_child(mission_tab)
	mission_tab.z_index = 6
	mission_tab.label.text = "Hãy sắp xếp các tấm thẻ theo đúng thứ tự"
	
	card_panel = card_panel_scene.instantiate()
	main_panel.add_child(card_panel)
	card_panel.show()
	card_list = card_panel.get_card_list()
	pass


func end_sort_game_fail() -> void:
	card_list = null
	# Destroy node and set card panel to null
	card_panel.queue_free()
	await card_panel.tree_exited
	card_panel = null

	# The same for mission tab
	mission_tab.queue_free()
	await mission_tab.tree_exited
	mission_tab = null
	
	Dialogic.start("cards_sort_fail")


func end_sort_game() -> void:
	GameEventBus.play_animation.emit("mission_completed")
	await get_tree().create_timer(2.0).timeout
	card_list = null
	
	# Destroy node and set card panel to null
	card_panel.queue_free()
	await card_panel.tree_exited
	card_panel = null

	# The same for mission tab
	mission_tab.queue_free()
	await mission_tab.tree_exited
	mission_tab = null
	
	Dialogic.start("cards_sorted")
	pass


func is_cards_sorted() -> bool:
	for i in range(correct_order.size()):
		if not card_list.get_child(i).name == correct_order[i]:
			return false
	return true
