extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10
var current_health

func _ready() -> void:
	current_health = max_health


func damage(damage_amount: float):
	# this prevents the health being less than 0
	current_health = max(current_health - damage_amount, 0)
	
	# call defered is a method of callable that calls 
	# a callback on an idle frame
	# prevents error with colision shape
	Callable(check_death).call_deferred()


func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
