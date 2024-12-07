extends Node2D


var world = []
#var world_data = int[2][16][16]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Player.set_world_info($World/TileMap_Mid)
	#print($World.World/TileMap_Mid)
	#print($World/TileMap_Mid.tile_map_data)
	

	#generate level
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
