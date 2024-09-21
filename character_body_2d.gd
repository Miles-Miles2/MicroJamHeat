extends CharacterBody2D


const SPEED = 3000.0
@export var heldObj: Node2D


func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * SPEED * delta
	move_and_slide()
	
	rotation = global_position.direction_to(get_global_mouse_position()).angle()
	#print($mouseDetector.global_position)
	$mouseDetector.set_global_position(get_global_mouse_position())
	if (Input.is_action_just_pressed("action")):
		if heldObj == null:
			for obj in $mouseDetector.get_overlapping_areas():
				#print(obj.name)
				if obj.is_in_group("holdable") and heldObj == null:
					print("hold " + obj.name)
					grabItem(obj)
					break
			
	if (Input.is_action_just_pressed("secondary")):
		if heldObj:
			dropItem()
		
	if Input.is_action_pressed("action"):
		if heldObj:
			heldObj.action(true)
	else:
		if heldObj:
			heldObj.action(false)

func dropItem():
	heldObj.reparent(get_tree().root.get_child(0))
	heldObj = null

func grabItem(obj: Node2D):
	heldObj = obj
	obj.reparent(self)
	obj.rotation = 0
	obj.position = Vector2(10, 0)
	#obj.rotation = rotation
