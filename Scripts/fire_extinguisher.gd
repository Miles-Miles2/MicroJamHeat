extends Area2D

var timer: float = 0
var activated: bool = false
var amountLeft := 30.0


func _process(delta: float) -> void:
	timer += delta
	#print(timer)
	if activated:
		amountLeft -= delta

	if amountLeft <= 0:
		queue_free()
		
	if timer > 0.1:
		timer -= 0.1
		if activated and amountLeft > 0:
			for obj in $extinguishArea.get_overlapping_areas():
				if obj.is_in_group("fire"):
					obj.extinguish(10)

func action(doAction: bool):
	$CPUParticles2D.emitting = doAction
	activated = doAction
