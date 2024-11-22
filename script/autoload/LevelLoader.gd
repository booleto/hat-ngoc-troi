extends Node

enum LEVEL {
	MAIN_MENU,
	TEST_LEVEL
}

var level_map: Dictionary = {
	LEVEL.MAIN_MENU : load("res://level/main_menu.tscn"),
	LEVEL.TEST_LEVEL : load("res://level/test_level.tscn")
}

func load_level(level: LEVEL):
	get_tree().change_scene_to_packed(level_map[level])
