extends Node


func _ready() -> void:
	randomize()


func play_sfx(sfx: String, db: float = 0, scene_to_add: Node = null) -> void:
	var player: AudioPlayer = load("res://scenes/sound/audio_player.tscn").instantiate()
	
	if scene_to_add:
		scene_to_add.add_child(player)
	else:
		get_node("/root").add_child(player)
	
	player.stream = load(sfx)
	player.volume_db = db
	
	player.play()


func play_random_sfx(sfxs: Array[String], db: float = 0, scene_to_add: Node = null) -> void:
	var player: AudioPlayer = load("res://scenes/sound/audio_player.tscn").instantiate()
	
	if scene_to_add:
		scene_to_add.add_child(player)
	else:
		get_node("/root").add_child(player)
	
	var index: int = 0
	# Gets random number according to the SFXs size
	index = randi_range(0, sfxs.size() - 1)
	
	# Gets the sfx according to the index generated above
	var sfx: String = sfxs[index]
	
	player.stream = load(sfx)
	player.volume_db = db
	
	player.play()


func play_soundtrack(soundtrack: String, db: float = 0, scene_to_add: Node = null) -> void:
	var player: AudioPlayer = load("res://scenes/sound/audio_player.tscn").instantiate()
	
	if scene_to_add:
		scene_to_add.add_child(player)
	else:
		get_node("/root").add_child(player)
	
	player.stream = load(soundtrack)
	player.volume_db = db
	
	player.play()
