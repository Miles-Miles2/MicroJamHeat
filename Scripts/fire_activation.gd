extends Node

@onready var fire_array = get_tree().get_nodes_in_group("fire")
@onready var timer: Timer = $Timer

var temp = 0

func _ready() -> void:
	timer.start()


func generate():
	var fire_index = int(randf_range(0,fire_array.size()-1))
	return fire_index
	
func enable(fuego):
	fuego.size = 25
	fuego.get_node("firecollide").disabled = false
	fuego.set_visible(true)
	fuego.PROCESS_MODE_ALWAYS
	fuego.firesfx.play()
	_ready()

func _on_timer_timeout() -> void:
	var num = generate()
	enable(fire_array[num])
	temp += 1
	_ready()
	
	
