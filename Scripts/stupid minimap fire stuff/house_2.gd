extends Area2D

@onready var fire2: AnimatedSprite2D = $"../../minimap/fire2"
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
		fire2.scale = Vector2(5+x,5+x)
		fire2.set_visible(true)
	else:
		fire2.set_visible(false)
