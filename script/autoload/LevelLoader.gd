extends Node

enum LEVEL {
	MAIN_MENU,
	CHIEM_BAO_MAY,
	CHIEM_BAO_THAN_NONG,
	CONG_DEN_TU_LINH,
	THANH_DIA_TU_LINH,
	TEST_LEVEL
}

var level_map: Dictionary = {
	LEVEL.MAIN_MENU : load("res://level/main_menu.tscn"),
	LEVEL.TEST_LEVEL : load("res://level/test_level.tscn"),
	LEVEL.CONG_DEN_TU_LINH: load("res://level/cong_den_tu_linh.tscn")
}

func load_level(level: LEVEL):
	get_tree().change_scene_to_packed(level_map[level])

func load_level_from_name(level_name: String):
	var next_level: LEVEL = LEVEL.get(level_name)
	load_level(next_level)
	
