extends Node

func _ready() -> void:
	Dialogic.start("drum_done")
	GlobalMusicPlayer.stop()
	GlobalMusicPlayer.play_music(GlobalMusicPlayer.SONG.DEN_PHUONG)
