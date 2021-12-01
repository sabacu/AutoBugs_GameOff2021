extends Node2D

func play_menu():
	stop_musics()
	$MenuMusic.play()

func stop_musics():
	$RaceMusic.stop()
	$PlacarFX.stop()
	$MenuMusic.stop()

func play_race():
	stop_musics()
	$RaceMusic.play()
	yield($RaceMusic,"finished")
	$RaceMusic.play()
