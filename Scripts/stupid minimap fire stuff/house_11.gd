extends Area2D

@onready var fire11: AnimatedSprite2D = $"../../minimap/fire11"
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
		fire11.scale = Vector2(5+x,5+x)
		fire11.set_visible(true)
	else:
		fire11.set_visible(false)
