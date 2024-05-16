extends Node

var musicPlayers = []

var mutex : Mutex
var threads = []
signal thread_exit

var Music = {
	"GothicCuteInst": "res://audio/music/gothic/peritune_gothic_inst_loop.ogg",
	"CrimsonMoon": "res://audio/music/peritune_crimson_moon_loop.ogg"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	mutex = Mutex.new()
	thread_exit.connect(_close_threads)

func play_random_music() -> void:
	var number = randi_range(0,Music.size()-1)
	play(Music[Music.keys()[number]])

func play(path, start_time = 0.0, volume = 0.0) -> AudioStreamPlayer:
	var index = _load_audio(path)
	_play_index(index, start_time, volume)
	return musicPlayers[index]

func play_synced(path1, path2, start_time = 0.0, volume1 = 0.0, volume2 = volume1):
	var index1 = _load_audio(path1)
	var index2 = _load_audio(path2)
	_play_index(index1, start_time, volume1)
	_play_index(index2, start_time, volume2)
	return [musicPlayers[index1], musicPlayers[index2]]

func fade_out(musicPlayer):
	var thread = Thread.new()
	thread.start(_fade_out_thread.bind(musicPlayer))
	threads.append(thread)

func _fade_out_thread(musicPlayer):
	var player = musicPlayer
	#var player = musicPlayers[index]
	
	#if not playing, do nothing
	if player.playing == false:
		thread_exit.emit()
		return
	
	#fade out over 5 seconds
	var fade_out_duration_sec = 8
	var step_sec = 0.1
	var step_count = fade_out_duration_sec / step_sec
	var step_size = (player.volume_db + 80) / step_count
	while player.volume_db > -80.0:
		#print("Volume_db: %0.2f" % player.volume_db)
		player.volume_db -= step_size
		await get_tree().create_timer(step_sec).timeout
	player.stop()
	
	#done
	thread_exit.emit()
	return

func fade_out_all():
	#for i in range(len(musicPlayers)):
	#	fade_out(i)
	for musicPlayer in musicPlayers:
		fade_out(musicPlayer)

func _load_audio(path) -> int:
	var audio = load(path)
	if audio == null:
		print_debug('Attempted to play non-existent audio:\n"%s"' % path)
		return -1
	
	#find an existing audioplayer that's not playing and not paused
	var index = -1
	for i in range(len(musicPlayers)):
		if (musicPlayers[i].playing == false) and (musicPlayers[i].get_playback_position()+0.1 > musicPlayers[i].stream.get_length()):
			index = i
			break
	
	#create new audioplayer if all are full
	if index == -1:
		index = musicPlayers.size()
		musicPlayers.append(AudioStreamPlayer.new())
		musicPlayers[index].bus = "Music"
		add_child(musicPlayers[index])
	
	#set audio stream
	musicPlayers[index].stream = audio
	return index

func _play_index(index, start_time, volume) -> void:
	musicPlayers[index].volume_db = volume
	musicPlayers[index].play(start_time)

func _close_threads():
	mutex.lock()
	for i in range(len(threads)):
		threads[i].wait_to_finish()
		threads.pop_at(i)
	mutex.unlock()

func _exit_tree():
	_close_threads()
