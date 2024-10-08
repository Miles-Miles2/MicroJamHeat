extends Area2D

var timer: float = 0
var activated: bool = false
var amountLeft := 15.0


func _process(delta: float) -> void:
	var space_rid = get_world_2d().space
	var space_state = PhysicsServer2D.space_get_direct_state(space_rid)
	
	$ColorRect.size = Vector2((amountLeft/15) * 20, 3)
	
	timer += delta
	#print(timer)
	if activated:
		amountLeft -= delta

	if amountLeft <= 0:
		queue_free()
	$CPUParticles2D.lifetime = 1
	
	if timer > 0.1:
		timer -= 0.1
		if activated and amountLeft > 0:
			for obj in $extinguishArea.get_overlapping_areas():
				if obj.is_in_group("fire"):
					var query = PhysicsRayQueryParameters2D.create(global_position, obj.global_position)
					query.exclude = [get_tree().root.get_child(0).get_node("pepper")]
					var result = space_state.intersect_ray(query)
					if result:
						$CPUParticles2D.lifetime = (result.position - global_position).length()/250
						if (result.position - obj.global_position).length() < 50:
							obj.extinguish(10)


func action(doAction: bool):
	$CPUParticles2D.emitting = doAction
	activated = doAction
	$ColorRect.visible = doAction
