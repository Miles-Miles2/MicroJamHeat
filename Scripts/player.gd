extends CharacterBody2D


const SPEED = 10000.0

var heldObj: Node2D

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta: float) -> void:
	# Add the gravity.
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input * SPEED * delta
	move_and_slide()
	
	rotation = global_position.direction_to(get_global_mouse_position()).angle()
	print($mouseDetector.global_position)
	$mouseDetector.set_global_position(get_global_mouse_position())
	
	
