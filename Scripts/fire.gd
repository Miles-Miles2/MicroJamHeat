extends Node2D

#max fire size: 100
@export var size: float = 25
@onready var collision: CollisionShape2D = $firecollide
var grow = true
@onready var firesfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	get_tree().call_group("fire", "disable")
	

func _process(delta: float) -> void:
	scale = Vector2(size/25, size/25)
	if grow:
		size += delta * 2
		
	if size >= 100:
		grow = false
	if scale.x + scale.y < 1:
		grow = true
		size = 25
		get_node("firecollide").disabled = true
		set_visible(false)
		PROCESS_MODE_DISABLED

func extinguish(amount: float):
	size -= amount
	
func disable():
	get_node("firecollide").disabled = true
	set_visible(false)
	PROCESS_MODE_DISABLED
	
