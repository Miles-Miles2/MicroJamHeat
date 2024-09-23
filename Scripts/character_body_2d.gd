extends CharacterBody2D


const SPEED = 9000.0
@export var heldObj: Node2D = null
@export var currentVehicle: Node2D
@export var operatingVehicle: bool = false
var holdingHose := false

var extinguisherInInventory := true
var extinguisherScene = preload("res://Scenes/fire_extinguisher.tscn")


func _physics_process(delta: float) -> void:
	
	if not is_instance_valid(heldObj):
		heldObj = null
	
	var input = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("toggleExtinguisher"):
		if extinguisherInInventory == true and not operatingVehicle and not heldObj:
			var clone = extinguisherScene.instantiate()
			add_child(clone)
			grabItem(clone)
			extinguisherInInventory = false
		elif extinguisherInInventory == false and heldObj:
			if heldObj.is_in_group("extinguisher"):
				heldObj.queue_free()
				heldObj = null
				extinguisherInInventory = true
	
	
	if not operatingVehicle:
		velocity = input * SPEED * delta
		move_and_slide()
		
		rotation = global_position.direction_to(get_global_mouse_position()).angle()
		#print($mouseDetector.global_position)
		$mouseDetector.set_global_position(get_global_mouse_position())
		if (Input.is_action_just_pressed("action")):
			if heldObj == null:
				for obj in $mouseDetector.get_overlapping_areas():
					print(obj.name)
					if obj.is_in_group("holdable"):
						if (obj.global_position - global_position).length() < 50:
							print("can grab")
							if obj.is_in_group("hose"):
								print("grab hose")
								heldObj = obj.get_parent()
								holdingHose = true
								heldObj.beingHeld = true
								break
							else:
								print("hold " + obj.name)
								grabItem(obj)
								break
				for obj in $mouseDetector.get_overlapping_bodies():
					if obj.is_in_group("vehicle") and heldObj == null:
						obj.driving = true
						operatingVehicle = true
						currentVehicle = obj
						reparent(obj)
						position = Vector2.ZERO
						set_collision_layer_value(1, false)
						break
			
		if Input.is_action_pressed("action"):
			if heldObj:
				print(heldObj)
				heldObj.action(true)
		else:
			if heldObj:
				heldObj.action(false)
				
	if holdingHose == true and heldObj:
		heldObj.targetPos = global_position
		heldObj.get_node("Area2D").rotation = rotation
		heldObj.get_node("CPUParticles2D").rotation = rotation
		heldObj.get_node("RayCast2D").rotation = rotation
		heldObj.get_node("RayCast2D").set_global_position(global_position)
	
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
			else:
				for obj in $mouseDetector.get_overlapping_areas():
					#print(obj.name)
					if obj.is_in_group("hose"):
						obj.get_parent().cleanHose()



func dropItem():
	if holdingHose == false:
		heldObj.reparent(get_tree().root.get_child(0))
	else:
		holdingHose = false
		heldObj.beingHeld = false
	heldObj = null

func grabItem(obj: Node2D):
	heldObj = obj
	obj.reparent(self)
	obj.rotation = 0
	obj.position = Vector2(10, 0)
	#obj.rotation = rotation
