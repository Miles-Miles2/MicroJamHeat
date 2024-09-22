extends CharacterBody2D


const SPEED = 9000.0
@export var heldObj: Node2D
@export var currentVehicle: Node2D
@export var operatingVehicle: bool = false
var holdingHose := false

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down")
	if not operatingVehicle:
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
						if obj.is_in_group("hose"):
							heldObj = obj.get_parent()
							holdingHose = true
						else:
							print("hold " + obj.name)
							grabItem(obj)
							break
				for obj in $mouseDetector.get_overlapping_bodies():
					if obj.is_in_group("vehicle"):
						obj.driving = true
						operatingVehicle = true
						currentVehicle = obj
						reparent(obj)
						position = Vector2.ZERO
						set_collision_layer_value(1, false)
						break
			
		if Input.is_action_pressed("action"):
			if heldObj:
				heldObj.action(true)
		else:
			if heldObj:
				heldObj.action(false)
				
	if holdingHose == true and heldObj:
		heldObj.targetPos = global_position
	
	if (Input.is_action_just_pressed("secondary")):
			if operatingVehicle:
				
				position = Vector2(-20, 20).rotated(currentVehicle.rotation)
				reparent(get_tree().root.get_child(0))
				set_collision_layer_value(0, true)
				operatingVehicle = false
				currentVehicle.driving = false
				currentVehicle = null
				
				print("exiting")
			elif heldObj:
				dropItem()


func dropItem():
	if holdingHose == false:
		heldObj.reparent(get_tree().root.get_child(0))
	else:
		holdingHose = false
	heldObj = null

func grabItem(obj: Node2D):
	heldObj = obj
	obj.reparent(self)
	obj.rotation = 0
	obj.position = Vector2(10, 0)
	#obj.rotation = rotation
