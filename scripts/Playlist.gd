extends Node

# GET ALL SONGS FROM FOLDER
func list_files_in_directory(folder):
	var files = []
	var dir = Directory.new()
	dir.open(folder)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.ends_with(".mp3"):
				files.append(file)

	return files
	
onready var player = get_node("AudioStreamPlayer")
var path = "res://assets/audio/copyrighted_music/"
var songs = list_files_in_directory(path)
var index = 0
var songs_size = songs.size() # 15
onready var songinfo_label = get_parent().get_node("HUD/SongInfo")

func _ready():
	randomize()
	var rand_value = randi() % songs.size() # RANDOM SONG
	player.stream = load(path + songs[rand_value])
	songinfo_label.text = "Now playing:" + "\n" + songs[rand_value]
	player.play()
	
func _process(_delta):
	if Input.is_action_just_pressed("mute"):
		if (player.stream_paused):
			player.stream_paused = false
		else:
			player.stream_paused = true
	if Input.is_action_just_pressed("prev_song"):
		prev_song()
	if Input.is_action_just_pressed("next_song"):
		next_song()
		
func _on_AudioStreamPlayer_finished():
	next_song()

func next_song():
	# LOOPS BACK TO BEGINNING OF QUEUE
	if index > songs_size - 2:
		index = 0
		player.stream = load(path + songs[index])
		songinfo_label.text = "Now playing:" + "\n" + songs[index]
	else:
		player.stream = load(path + songs[index + 1])
		songinfo_label.text = "Now playing:" + "\n" + songs[index + 1]
		index = index + 1
	player.play()
	
func prev_song():
	# LOOPS BACK TO END OF QUEUE
	if index < -songs_size + 2:
		index = 0
		player.stream = load(path + songs[index])
		songinfo_label.text = "Now playing:" + "\n" + songs[index]
	else:
		player.stream = load(path + songs[index - 1])
		songinfo_label.text = "Now playing:" + "\n" + songs[index - 1]
		index = index - 1
	player.play()
