extends Line2D

const segmentLength = 10
const MAX_SEGMENTS = 50
var numSegments = 1


@export var targetPos := Vector2.ZERO

@export var parentObj: Node2D

@export var beingHeld: bool = false
@export var offset: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = $Area2D.global_position - parentObj.global_position
	targetPos = global_position
	for i in range(numSegments):
		add_point(Vector2(100 + i * segmentLength, 50))
		
		
func action(held: bool):
	$CPUParticles2D.emitting = held
	if held == true:
		if $RayCast2D.is_colliding():
			$extinguishArea.set_global_position($RayCast2D.get_collision_point())
		else:
			$extinguishArea.set_global_position($RayCast2D.global_position + Vector2.RIGHT.rotated($RayCast2D.rotation)*300)
		for obj in $extinguishArea.get_overlapping_areas():
			if obj.is_in_group("fire"):
				obj.extinguish(0.5)
				#print("touching fire")
	
func ik():
	points[0] = targetPos - global_position
	$Area2D.set_global_position(targetPos)
	
	for i in range(1, points.size()):
		var dir = points[i-1] - points[i]
		dir = dir.normalized() * segmentLength
		points[i] = points[i-1] - dir
'''		
func reverseIK():
	points[points.size()-1] = position
	for i in range(points.size()-2,-1, -1):
		print(i)
		var dir = points[i+1] - points[i]
		dir = dir.normalized() * segmentLength
		points[i] = points[i+1] - dir
'''
func cleanHose():
	$Area2D.set_global_position($basePos.global_position)
	targetPos = $basePos.global_position
	for i in range(points.size()-1, 0, -1):
		remove_point(i)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hitPoint = $RayCast2D.get_collision_point()
	var dist
	if $RayCast2D.get_collider() != null:
		dist = min((hitPoint - targetPos).length(), 300)
	else:
		dist = 300
	
	$CPUParticles2D.lifetime = dist/300
	$CPUParticles2D.set_global_position(targetPos)
	
	#print(points.size())
	$basePos.set_global_position(parentObj.global_position + (offset.rotated(parentObj.rotation)))
	if points.size() <= 2 and beingHeld == false:
		targetPos = $basePos.global_position
		$Area2D.set_global_position(targetPos)
	
	ik()
		
	while (points[points.size()-1]-$basePos.position).length() > segmentLength:
		add_point($basePos.position)
		ik()
	
