extends Node

const MAX_RANGE = 150


# packed scene type means this node will get a scene as param
@export var sword_abilty: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#signals in gd are events in react
	# timeout is the signals name
	$Timer.timeout.connect(on_timer_timeout)


# when the timer signal is sent this is the callback
# it will spawn a sword
# new instantiated scenes have to be sent to the parent (main)
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	
	# filter enemies array remove enemies to far away
	enemies = enemies.filter(
		func(enemy: Node2D) : return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
		)
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	
	if enemies.size() == 0:
		return
	
	# instantiate sword
	var sword_instance = sword_abilty.instantiate() as Node2D
	
	# add sword to main
	# when this happens sword_instance is spawned at the origin of main [0,0]
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position
	
	# this randomises the rotation of the vector 
	# tau is two times pie
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	# get the direction of the enemy vector
	var enemy_dir = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_dir.angle()
