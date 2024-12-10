extends Control


var progress: Array = []
var scene_to_load: String = ""
var scene_load_status: int = 0
var loading: bool = false

@onready var percentage_label: Label = %PercentageLabel


func _ready() -> void:
	hide()


func _process(_delta: float) -> void:
	# If the scene is loading, the code will run
	if loading == true:
		scene_load_status = ResourceLoader.load_threaded_get_status(scene_to_load, progress)
		percentage_label.text = str(progress[0] * 100) + "%"
		
		if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			loading = false
			var new_scene = ResourceLoader.load_threaded_get(scene_to_load)
			
			# If game is paused, unpause it
			if get_tree().paused == true:
				get_tree().paused = false
			
			hide()
			get_tree().change_scene_to_packed(new_scene)


func load_scene(new_scene_name: String) -> void:
	scene_to_load = new_scene_name
	ResourceLoader.load_threaded_request(scene_to_load)
	loading = true
	show()
