extends Area2D

@onready var fire5: AnimatedSprite2D = $"../../minimap/fire5"
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
		fire5.scale = Vector2(5+x,5+x)
		fire5.set_visible(true)
	else:
		fire5.set_visible(false)
