extends Camera2D

var target_position = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# gd can have multiple cameras in one scene
	# this tells it to use this camera
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	aquire_target()
	
	# this adds camera smoothing
	# link that explains framerate independant smoothing ie ... lerp(target_position, 1.0 - exp(-delta * 10))
	# https://www.rorydriscoll.com/2016/03/07/frame-rate-independent-damping-using-lerp/
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))


func aquire_target():
	# player scene was put in player group
	# this makes it global to all other nodes
	var player_nodes = get_tree().get_nodes_in_group("player")
	
	# get nodes in group returns an array
	# get first node in array
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		target_position = player.global_position

	
