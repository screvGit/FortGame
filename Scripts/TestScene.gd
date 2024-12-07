extends Node2D


var world = []
var world_tile_set = preload("res://Assets/BlockTiles.tres")
#var world_data = int[2][16][16]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Player.set_world_info($World/TileMap_Mid)

	

	#generate level
	for z in range(0, 64):
		var new_layer = TileMapLayer.new()
		new_layer.tile_set = world_tile_set
		world.append(new_layer)
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
				
	
	for i in range(0, 64):
		for j in range(0, 64):
			$World/TileMap_Btm.set_cell(Vector2i(i, j), 0, Vector2i(2, 0)) # Set floor tiles to dirt
			if (i < 2 or i > 13) or (j < 2 or j > 13):
				$World/TileMap_Mid.set_cell(Vector2i(i, j), 0, Vector2i(3, 0)) # Set tile to stone
			else:
				$World/TileMap_Mid.set_cell(Vector2i(i, j)) # Set tile to air


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
