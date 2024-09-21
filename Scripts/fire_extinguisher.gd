extends Area2D

var timer: float = 0

func _process(delta: float) -> void:
	timer += delta
	#print(timer)
	if timer > 0.5:
		timer -= 0.5
		for obj in $extinguishArea.get_overlapping_areas():
			if obj.is_in_group("fire"):
				obj.extinguish(3)

func action(doAction: bool):
	$CPUParticles2D.emitting = doAction
