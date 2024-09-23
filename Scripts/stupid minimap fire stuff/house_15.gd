extends Area2D

@onready var fire15: AnimatedSprite2D = $"../../minimap/fire15"
@onready var timer: Timer = $"../Timer"


func _ready():
	timer.start()

func _on_timer_timeout() -> void:
	var x = 0
	print (get_overlapping_areas())
	for i in get_overlapping_areas():
		if i.is_in_group("fire"):
			x += 1
	if x != 0:
		fire15.scale = Vector2(5+x,5+x)
		fire15.set_visible(true)
	else:
		fire15.set_visible(false)
