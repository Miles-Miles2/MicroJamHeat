extends Node2D


#max fire size: 100
@export var size: float

func _process(delta: float) -> void:
	size += delta * 1
	scale = Vector2(size/25, size/25)
	if scale.x + scale.y < 1:
		queue_free()

func extinguish(amount: float):
	size -= amount
