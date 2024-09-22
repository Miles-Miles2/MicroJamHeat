extends Node2D


#max fire size: 100
@export var size: float

func _ready():
	get_tree().call_group("fire", "disable")
	

func _process(delta: float) -> void:
	size += delta * 1
	scale = Vector2(size/25, size/25)
	if scale.x + scale.y < 1:
		set_visible(false)
		set_process(false)

func extinguish(amount: float):
	size -= amount
	
func disable():
	set_visible(false)
	set_process(false)
