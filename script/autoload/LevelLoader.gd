extends Node

enum LEVEL {
	MAIN_MENU,
	CG1,
	CG2,
	CG3,
	CG4,
	CG5,
	CG6,
	CG7,
	CG8,
	CG9,
	CHIEM_BAO_MAY,
	CONG_DEN_TU_LINH,
	THANH_DIA_TU_LINH,
	DEN_PHUONG,
	DRUM_MINIGAME,
	DEN_PHUONG_SAU_MINIGAME
}

var level_map: Dictionary = {
	LEVEL.MAIN_MENU : load("res://level/main_menu.tscn"),
	LEVEL.CG1 : load("res://level/cg1.tscn"),
	LEVEL.CG2 : load("res://level/cg2.tscn"),
	LEVEL.CG3 : load("res://level/cg3.tscn"),
	LEVEL.CG4 : load("res://level/cg4.tscn"),
	LEVEL.CG5 : load("res://level/cg5.tscn"),
	LEVEL.CG6 : load("res://level/cg6.tscn"),
	LEVEL.CG7 : load("res://level/cg7.tscn"),
	LEVEL.CG8 : load("res://level/cg8.tscn"),
	LEVEL.CG9 : load("res://level/cg9.tscn"),
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
