extends Node

enum LEVEL {
	MAIN_MENU,
	TEST_LEVEL,
	CHIEM_BAO_MAY,
	CONG_DEN_TU_LINH,
	THANH_DIA_TU_LINH,
	DEN_PHUONG,
	DRUM_MINIGAME,
	DEN_PHUONG_SAU_MINIGAME
}

var level_map: Dictionary = {
	LEVEL.MAIN_MENU : load("res://level/main_menu.tscn"),
	LEVEL.TEST_LEVEL : load("res://level/test_level.tscn"),
	LEVEL.CHIEM_BAO_MAY : load("res://level/chiem_bao_may.tscn"),
	LEVEL.CONG_DEN_TU_LINH : load("res://level/cong_den_tu_linh.tscn"),
	LEVEL.DEN_PHUONG : load("res://level/level_phuong.tscn"),
	LEVEL.DRUM_MINIGAME : load("res://level/drum_minigame.tscn"),
	LEVEL.DEN_PHUONG_SAU_MINIGAME : load("res://level/level_phuong_after_minigame.tscn")
}

func load_level(level: LEVEL):
	get_tree().change_scene_to_packed(level_map[level])

func load_level_from_name(level_name: String):
	var next_level: LEVEL = LEVEL.get(level_name)
	if next_level != null:
		load_level(next_level)
	else:
		print("Level not found")
