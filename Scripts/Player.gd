extends CharacterBody2D

# Movement values
@export var move_speed = 20
var tile_size = 64.0
var turn_counter = 0
var y_dir = 0
var x_dir = 0

# World values
@export var z_level = 49
var tile_position = Vector2i(0, 0)
var lower_layer = TileMapLayer.new()
var curr_layer = TileMapLayer.new()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	print(z_level)
	tile_position = Vector2i(self.position / tile_size)
	
	#print('standing on id: ' + str(world.get_cell_source_id(tile_position)))
	handle_rotation()
	
	if turn_counter > move_speed:
		turn_counter = 0
		get_movement_input()
		if can_move():
			self.position = self.position + (tile_size * Vector2(x_dir, -1 * y_dir))
		y_dir = 0
		x_dir = 0
	elif turn_counter + (move_speed / 2) > move_speed:
		get_movement_input()
	
	if Input.is_action_pressed("Interact"):
		mine_block()
		
	if Input.is_action_just_pressed("Down"):
		z_level -= 1
	
	if Input.is_action_just_pressed("Up"):
		z_level += 1
	
	turn_counter+=1
		
func can_move() -> bool:
	# is tile ahead air
	return curr_layer.get_cell_source_id(Vector2i(tile_position.x + x_dir, tile_position.y - y_dir)) == -1 
	
func handle_rotation() -> void:
	if y_dir != 0:
		self.rotation = deg_to_rad(y_dir * 90 - 90)
	
	if x_dir != 0:
		self.rotation = deg_to_rad(x_dir * 90)
		
func mine_block():
	if self.rotation_degrees == 0: 		# Facing North
		if curr_layer.get_cell_source_id(tile_position + Vector2i(0, -1)) == 0: # Is block minable?
			curr_layer.set_cell(tile_position + Vector2i(0, -1), -1) # Mine block to North
	elif self.rotation_degrees == 90: 	# Facing East
		if curr_layer.get_cell_source_id(tile_position + Vector2i(1, 0)) == 0: # Is block minable?
			curr_layer.set_cell(tile_position + Vector2i(1, 0), -1) # Mine block to East
	elif self.rotation_degrees == -180: 	# Facing South
		if curr_layer.get_cell_source_id(tile_position + Vector2i(0, 1)) == 0: # Is block minable?
			curr_layer.set_cell(tile_position + Vector2i(0, 1), -1) # Mine block to South
	elif self.rotation_degrees == -90: 	# Facing West
		if curr_layer.get_cell_source_id(tile_position + Vector2i(-1, 0)) == 0: # Is block minable?
			curr_layer.set_cell(tile_position + Vector2i(-1, 0), -1) # Mine block to West
		
		
func set_layer_info(new_lower_layer: TileMapLayer, new_curr_layer: TileMapLayer) -> void:
	lower_layer = new_lower_layer
	curr_layer = new_curr_layer
	
func get_movement_input() -> void:
	var new_y_dir = Input.get_axis("South", "North")
	if new_y_dir != 0:
		x_dir = 0
		y_dir = new_y_dir
	
	var new_x_dir = Input.get_axis("East", "West")
	if new_x_dir != 0:
		y_dir = 0
		x_dir = new_x_dir
	
	
	
	
	
	
	
	
	
