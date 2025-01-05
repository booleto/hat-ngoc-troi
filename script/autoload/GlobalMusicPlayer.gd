extends AudioStreamPlayer

enum SONG {
	PROLOGUE, CONG_TDTL, DEN_PHUONG, DEN_QUY
}

func play_music(song: SONG):
	match song:
		SONG.PROLOGUE:
			self.stream = load("res://asset/sound/bgm/prologue.mp3")
		SONG.CONG_TDTL:
			self.stream = load("res://asset/sound/bgm/cổng.mp3")
		SONG.DEN_PHUONG:
			self.stream = load("res://asset/sound/bgm/Đền Phụng.mp3")			
		SONG.DEN_QUY:
			self.stream = load("res://asset/sound/bgm/Đền Quy.mp3")
			
	play(0.0)
