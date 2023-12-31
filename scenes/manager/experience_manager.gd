extends Node

signal experience_updated(current_experience: float, target_experience: float)

var current_experience = 0
var current_level = 1
var target_experience = 5

const TARGET_EXP_GROWTH = 5


func _ready():
	# game event was made into a global autoload
	# connect to custom signal 
	GameEvents.experience_vile_collected.connect(on_experience_vile_collected)


func increment_experience(number: float):
	current_experience = min(current_experience + number, target_experience)
	experience_updated.emit(current_experience, target_experience)
	
	if current_experience == target_experience:
		current_level += 1
		target_experience += TARGET_EXP_GROWTH
		current_experience = 0
		experience_updated.emit(current_experience, target_experience)


func on_experience_vile_collected(number: float):
	increment_experience(number)
