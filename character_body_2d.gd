extends CharacterBody2D


const SPEED = 300.0



func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	print(input_vector)
	
	if input_vector:
		velocity = input_vector * SPEED
	else:
		velocity = input_vector
	move_and_slide()
