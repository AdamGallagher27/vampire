extends Node

@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: Node
@export var vile_scene: PackedScene

func _ready() -> void:
	# this component is listening for the died signal
	# calls on_died when it does
	(health_component as HealthComponent).died.connect(on_died)



func on_died():
	
	if randf() > drop_percent:
		return
	
	if vile_scene == null:
		return
	
	if not owner is Node2D:
		return
		
	var spawn_position = (owner as Node2D).global_position
	var vile_instance = vile_scene.instantiate() as Node2D
	owner.get_parent().add_child(vile_instance)
	vile_instance.global_position = spawn_position
	
