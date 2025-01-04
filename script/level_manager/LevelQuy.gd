extends Node

# Panels
@onready var statue_right_panel : PanelContainer = %StatueRightPanel
@onready var statue_left_panel : PanelContainer = %StatueLeftPanel
@onready var tea_table_panel : PanelContainer = %TeaTablePanel

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

var viewed_table: bool = false

func _ready() -> void:
	GameEventBus.play_animation.emit("arrows")
	Dialogic.signal_event.connect(_on_game_event)
	GameEventBus.game_event.connect(_on_game_event)
	
func _on_game_event(event: String):
	print_debug("Received Event: ", event)
	
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
		if not viewed_table:
			Dialogic.start("quy_inspect_tea_table")
			viewed_table = true
	if event == "hide_table":
		tea_table_panel.hide()
		
	handle_highlight_event(event)
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
	
