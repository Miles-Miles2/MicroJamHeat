extends Line2D

const segmentLength = 10
const MAX_SEGMENTS = 50
var numSegments = 1


@export var targetPos := Vector2.ZERO

@export var parentObj: Node2D


@export var offset: Vector2 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = $Area2D.global_position - parentObj.global_position
	targetPos = $Area2D.position
	for i in range(numSegments):
		add_point(Vector2(100 + i * segmentLength, 50))
		
		
func action(held: bool):
	pass

func ik():
	points[0] = targetPos - global_position
	$Area2D.position = targetPos
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
	for i in range(points.size(), -1, -1):
		remove_point(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(points.size())
	$basePos.set_global_position(parentObj.global_position + (offset.rotated(parentObj.rotation)))
	ik()
		
	while (points[points.size()-1]-$basePos.position).length() > segmentLength:
		add_point($basePos.position)
		ik()
	
