extends Node

enum TEA_STATE {
	NOT_STARTED, STARTED, HEAT_CUPS, GET_TEA, PLACE_TEA, POUR_WATER, RINSE, BREW, POUR
}

var tea_state: TEA_STATE = TEA_STATE.NOT_STARTED

# Panels
@onready var mission_tab_scene = preload("res://scene/dialogic/style/mainstyle/MissionTab/mission_tab.tscn")
@onready var statue_right_panel : PanelContainer = %StatueRightPanel
@onready var statue_left_panel : PanelContainer = %StatueLeftPanel
@onready var tea_table_panel : PanelContainer = %TeaTablePanel
@onready var main_panel : PanelContainer = %MainPanel


# Tea table elements
@onready var tea_table: TextureRect = %TeaTable
@onready var tea_stash: TextureRect = %TeaStash
@onready var tea_pot: TextureRect = %TeaPot
@onready var water_bowl: TextureRect = %WaterBowl
@onready var pad_1: TextureRect = %Pad1
@onready var pad_2: TextureRect = %Pad2
@onready var cup_1: TextureRect = %Cup1
@onready var cup_2: TextureRect = %Cup2
@onready var wash_water_bowl: TextureRect = %WashWaterBowl
@onready var spoon: TextureRect = %Spoon

# Timing game
@onready var timing_game_manager: TimingGameManager = %TimingGameManager

# Choice sets
@onready var choice_set_1: Control = %ChoiceSet1
@onready var choice_set_2: Control = %ChoiceSet2
@onready var choice_set_3: Control = %ChoiceSet3
@onready var choice_set_4: Control = %ChoiceSet4
@onready var choice_set_5: Control = %ChoiceSet5
@onready var choice_set_6: Control = %ChoiceSet6
@onready var choice_set_7: Control = %ChoiceSet7

var viewed_table: bool = false
var mission_tab: Node

func _ready() -> void:
	GameEventBus.play_animation.emit("arrows")
	Dialogic.signal_event.connect(_on_game_event)
	GameEventBus.game_event.connect(_on_game_event)
	GlobalMusicPlayer.stop()
	GlobalMusicPlayer.play_music(GlobalMusicPlayer.SONG.DEN_QUY)
	Dialogic.start("quy_start")
	
func _on_game_event(event: String):
	print_debug("Received Event: ", event)
	
	# Scene interactions
	if event == "view_statue_right":
		statue_right_panel.show()
	if event == "hide_statue_right":
		statue_right_panel.hide()
	if event == "view_statue_left":
		statue_left_panel.show()
	if event == "hide_statue_left":
		statue_left_panel.hide()
	if event == "view_table":
		tea_table_panel.show()
		if not viewed_table: # so that it is a one-time event
			Dialogic.start("quy_inspect_tea_table")
			viewed_table = true
	if event == "hide_table":
		tea_table_panel.hide()
		
	# Highlight events from dialogic
	handle_highlight_event(event)
	
	# Tea brew game progression
	if event == "start_tea_brew":
		tea_state = TEA_STATE.STARTED
		init_tea_mission()
		start_tea_minigame()
		
	if event == "heat_cup":
		tea_state = TEA_STATE.HEAT_CUPS
		choice_set_1.queue_free()
		GameEventBus.play_animation.emit("heat_cups")
		
	if event == "get_tea":
		tea_state = TEA_STATE.GET_TEA
		choice_set_2.queue_free()
		GameEventBus.play_animation.emit("get_tea")
		
	if event == "place_tea":
		tea_state = TEA_STATE.PLACE_TEA
		choice_set_3.queue_free()
		GameEventBus.play_animation.emit("place_tea")
		
	if event == "pour_water":
		tea_state = TEA_STATE.POUR_WATER
		choice_set_4.queue_free()
		GameEventBus.play_animation.emit("pour_water")
		
	if event == "rinse_tea":
		tea_state = TEA_STATE.RINSE
		choice_set_5.queue_free()
		GameEventBus.play_animation.emit("rinse_tea")
		
	if event == "brew_tea":
		tea_state = TEA_STATE.BREW
		choice_set_6.queue_free()
		GameEventBus.play_animation.emit("brew_tea")
		
	if event == "pour_tea":
		tea_state = TEA_STATE.POUR
		choice_set_7.queue_free()
		GameEventBus.play_animation.emit("pour_tea")
		
	if event == "tea_timing_passed":
		timing_game_manager.end_timing_game()
		match tea_state:
			TEA_STATE.HEAT_CUPS:
				GameEventBus.play_animation.emit("heat_cups_done")
				choice_set_2.show()
				
			TEA_STATE.GET_TEA:
				GameEventBus.play_animation.emit("get_tea_done")
				choice_set_3.show()
			
			TEA_STATE.PLACE_TEA:
				GameEventBus.play_animation.emit("place_tea_done")
				choice_set_4.show()
			
			TEA_STATE.POUR_WATER:
				GameEventBus.play_animation.emit("pour_water_done")
				choice_set_5.show()
				
			TEA_STATE.RINSE:
				GameEventBus.play_animation.emit("rinse_tea_done")
				choice_set_6.show()
				
			TEA_STATE.BREW:
				GameEventBus.play_animation.emit("brew_done")
				choice_set_7.show()
				
			TEA_STATE.POUR:
				GameEventBus.play_animation.emit("pour_tea_done")
				await get_tree().create_timer(2.0).timeout
				GameEventBus.play_animation.emit("mission_completed")
				terminate_tea_mission()
				await get_tree().create_timer(2.0).timeout
				tea_table_panel.hide()
				Dialogic.start("quy_after_tea")
				
	pass
	

func handle_highlight_event(event: String):
	if event == "show_tea_stash":
		highlight_table_object(tea_stash)
	if event == "show_pads_and_cups":
		highlight_table_object(pad_1)
		highlight_table_object(pad_2)
		highlight_table_object(cup_1)
		highlight_table_object(cup_2)
	if event == "show_wash_bowl":
		highlight_table_object(wash_water_bowl)
	if event == "show_water_bowl":
		highlight_table_object(water_bowl)
	if event == "show_spoon":
		highlight_table_object(spoon)
	if event == "show_pot":
		highlight_table_object(tea_pot)
	if event == "hide_tea_stash":
		unhighlight_table_object(tea_stash)
	if event == "hide_pads_and_cups":
		unhighlight_table_object(pad_1)
		unhighlight_table_object(pad_2)
		unhighlight_table_object(cup_1)
		unhighlight_table_object(cup_2)
	if event == "hide_wash_bowl":
		unhighlight_table_object(wash_water_bowl)
	if event == "hide_water_bowl":
		unhighlight_table_object(water_bowl)
	if event == "hide_spoon":
		unhighlight_table_object(spoon)
	if event == "hide_pot":
		unhighlight_table_object(tea_pot)
	pass
	
func highlight_table_object(obj: TextureRect):
	tea_table.z_index = -1
	obj.z_index = 1
	pass

func unhighlight_table_object(obj: TextureRect):
	tea_table.z_index = 0
	obj.z_index = 0
	pass

func start_tea_minigame():
	tea_table_panel.show()
	choice_set_1.show()
	
func init_tea_mission():
	mission_tab = mission_tab_scene.instantiate()
	main_panel.add_child(mission_tab)
	mission_tab.z_index = 6
	mission_tab.label.text = "Nhiệm vụ: Pha trà"
	
func terminate_tea_mission():
	mission_tab.queue_free()
	mission_tab = null
