extends Node

@onready var timer = $Timer


func get_time_elapsed():
	# this will get the passed time from the timer node
	return timer.wait_time - timer.time_left
