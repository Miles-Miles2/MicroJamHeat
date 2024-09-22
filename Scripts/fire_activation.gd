extends Node

@onready var fire_array = get_tree().get_nodes_in_group("fire")
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start()


func generate():
	var fire_index = int(randf_range(0,256))
	return fire_index
	
func enable(fuego):
	if fuego.is_in_group("fire"): 
		fuego.set_visible(true)
		fuego.set_process(true)
	_ready()

func _on_timer_timeout() -> void:
	var num = generate()
	enable(fire_array[num])
	
	
	
