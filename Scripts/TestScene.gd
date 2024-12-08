extends Node2D

const DEFAULT_WORLD_LAYER = preload("res://Scenes/DefaultWorldLayer.tscn")

var world = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#generate level
	for z in range(0, 64):
		var new_layer = DEFAULT_WORLD_LAYER.instantiate()
		#new_layer.tile_set = world_tile_set
		for x in range(0, 64):
			for y in range(0, 64):
				if z > 48:
					new_layer.set_cell(Vector2i(x, y)) 						# Set cell to Air
				elif z > 45:
					new_layer.set_cell(Vector2i(x, y), 0, Vector2i(2,0)) 	# Set cell to Dirt
				elif z > 2:
					new_layer.set_cell(Vector2i(x, y), 0, Vector2i(3,0)) 	# Set cell to Stone
				else:
					new_layer.set_cell(Vector2i(x, y), 0, Vector2i(0,0)) 	# Set cell to Bedrock
				
				# Debug shaft to bottom of world
				if x == 1 and y == 1:
					new_layer.set_cell(Vector2i(x, y)) 						# Set cell to Air
		new_layer.visible = false
		#new_layer.z_index = z
		world.append(new_layer)
		$World.add_child(world[z])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Player.set_layer_info(world[$Player.z_level - 1], world[$Player.z_level])
	
	for z in range(0, len(world)):
		if z > $Player.z_level:
			world[z].visible = false
		else:
			world[z].modulate = ($Player.z_level - z) * Color(.05, .05, .05) + Color(1, 1, 1)
			world[z].visible = true
	world[$Player.z_level].modulate = Color(.7, .7, .7)
	
	pass
