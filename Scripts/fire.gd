extends Node2D

#max fire size: 100
@export var size: float = 25
@onready var collision: CollisionShape2D = $firecollide
var grow = true
@onready var firesfx: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var firedie: AudioStreamPlayer2D = $firedie
var health = 3
@onready var manage: Node2D = $"../../game_manager"

func _ready():
	get_tree().call_group("fire", "disable")
	$CPUParticles2D.rotate(deg_to_rad(randf_range(-20, 20)))
	

func _physics_process(delta: float) -> void:
	scale = Vector2(size/25, size/25)
<<<<<<< HEAD
	size += delta * 5
	
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
		
	if size >= 200:
		size = 200
		health -= 1
		
		if health <= 0:
			get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
=======
	$CPUParticles2D.scale = Vector2(5,5) / scale
	if grow:
		size += delta * 2
>>>>>>> a53ff9f5c198afe4df6c53ce23ac630c171cfd23
		
	if scale.x + scale.y < 1:
<<<<<<< HEAD
		firedie.play()
=======
		$extinguish.play()
>>>>>>> a53ff9f5c198afe4df6c53ce23ac630c171cfd23
		grow = true
		size = 25
		get_node("firecollide").disabled = true
		set_visible(false)
		PROCESS_MODE_DISABLED

func extinguish(amount: float):
	size -= amount
	
func disable():
	get_node("firecollide").disabled = true
	set_visible(false)
	PROCESS_MODE_DISABLED
	
