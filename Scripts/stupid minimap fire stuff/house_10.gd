extends Area2D

@onready var fire10: AnimatedSprite2D = $"../../minimap/fire10"
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
		fire10.scale = Vector2(5+x,5+x)
		fire10.set_visible(true)
	else:
		fire10.set_visible(false)
