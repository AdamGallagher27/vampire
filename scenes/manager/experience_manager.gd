extends Node

var current_experience = 0


func _ready():
	# game event was made into a global autoload
	# connect to custom signal 
	GameEvents.experience_vile_collected.connect(on_experience_vile_collected)


func increment_experience(number: float):
	current_experience += number
	print(current_experience)


func on_experience_vile_collected(number: float):
	increment_experience(number)
