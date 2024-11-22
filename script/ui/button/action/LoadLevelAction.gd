extends ButtonAction
class_name LoadLevelAction

@export var level_to_load : LevelLoader.LEVEL

func execute() -> void:
	LevelLoader.load_level(level_to_load)
