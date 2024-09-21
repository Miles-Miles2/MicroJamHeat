extends RigidBody2D

@export var FL: Node2D
var FL_vel: Vector2
@export var FR: Node2D
var FR_vel: Vector2
@export var BL: Node2D
var BL_vel: Vector2
@export var BR: Node2D
var BR_vel: Vector2

@export var debugLineFL: Line2D
@export var debugLineFR: Line2D

@export var throttle: float
@export var steer: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func getVelocityAtPoint(point: Vector2):
	var rotVel = deg_to_rad(angular_velocity) * Vector2(-point.y, point.x)
	return linear_velocity + rotVel



func applyThrottle(wheelForce: Vector2, wheel: Node2D, throttle: float):
	#component of wheel force that is moving in direction of wheel
	var forwardForce = wheelForce.dot(Vector2.UP.rotated(rotation + wheel.rotation))
	#print(Vector2.UP.rotated(rotation))
	if abs(forwardForce) < 20:
		apply_force(Vector2.UP.rotated(rotation + wheel.rotation) * throttle * 200)
		

func applyBrake(wheelForce: Vector2, wheel: Node2D, brakePower: float):
	var forwardMagnitude = getVelocityAtPoint(wheel.global_position).dot(Vector2.UP.rotated(rotation + wheel.rotation))
	if getVelocityAtPoint(wheel.global_position).length() > 1:
		#print(forwardMagnitude)
		if (forwardMagnitude > 0):
			apply_force(Vector2.UP.rotated(rotation + wheel.rotation) * brakePower * -1)
		else:
			apply_force(Vector2.UP.rotated(rotation + wheel.rotation) * brakePower * 1)
	
	
func applySidewaysForce(wheel: Node2D):
	var sidewaysMagnitde = getVelocityAtPoint(wheel.global_position).dot(Vector2.RIGHT.rotated(rotation + wheel.rotation))
	#debugLineFL.points = [FL.global_position, FL.global_position + FL_vel]
	debugLineFR.points = [FR.global_position, FR.global_position + Vector2.RIGHT.rotated(rotation + FR.rotation) * sidewaysMagnitde]	
	print(sidewaysMagnitde)
	
	apply_force(Vector2.RIGHT.rotated(rotation + wheel.rotation) * -sidewaysMagnitde * 0.9, wheel.global_position - position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_central_force(Vector2(0, -5))
	var throttleInput: float = 0
	if (Input.is_action_pressed("drive_forward")):
		throttleInput += 1
	elif Input.is_action_pressed("drive_backward"):
		throttleInput += -1

	throttle += throttleInput * delta * 2
	throttle *= 0.8
	throttle = clamp(throttle, -1, 1)
	
	var steerTarget = Input.get_axis("drive_right", "drive_left")
	#steer += steerTarget * delta * 2
	steer += -steerTarget * delta * 3
	steer = clamp(steer, -1, 1)
	steer *= 0.9
	
	FL.rotation = steer * deg_to_rad(45)
	FR.rotation = steer * deg_to_rad(45)
	
	#apply throttle
	if (abs(throttle) > 0.1):
		pass
		#applyThrottle(FL_vel, FL, throttle)
		#applyThrottle(FR_vel, FR, throttle)
	elif linear_velocity.length() > 1:
		pass
		#applyBrake(FL_vel, FL, 10)
		#applyBrake(FR_vel, FR, 10)
	
	FL_vel *= 0.99
	FR_vel *= 0.99
	
	#print(FR_vel)
	#apply_force(FL_vel, (FL.global_position - position))
	#apply_force(FR_vel, FR.global_position - position)
	
	applySidewaysForce(FL)
	applySidewaysForce(FR)
	applySidewaysForce(BL)
	applySidewaysForce(BR)
	#draw lines
	#debugLineFL.points = [FL.global_position, FL.global_position + FL_vel]
	#debugLineFR.points = [FR.global_position, FR.global_position + FR_vel]
	
	
