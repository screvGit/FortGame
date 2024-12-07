extends CharacterBody2D

@export var move_speed = 15

var world = TileMapLayer.new()
var tile_position = Vector2i(0, 0)
var tile_size = 64.0
var turn_counter = 0
var y_dir = 0
var x_dir = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	tile_position = Vector2i(self.position / tile_size)
	
	print(world.get_cell_source_id(tile_position))
	
	handle_rotation()
	
	if turn_counter > move_speed:
		turn_counter = 0
		get_movement_input()
		if can_move():
			self.position = self.position + tile_size * Vector2(x_dir, -1 * y_dir)
		y_dir = 0
		x_dir = 0
	elif turn_counter + (move_speed / 2) > move_speed:
		get_movement_input()
	
	if Input.is_action_pressed("Interact"):
		mine_block()
	
	turn_counter+=1
		
func can_move() -> bool:
	if world.get_cell_source_id(Vector2i((self.position.x / tile_size) + x_dir, (self.position.y / tile_size) - y_dir)) == -1:
		return true
	else:
		return false
	
func handle_rotation() -> void:
	if y_dir != 0:
		self.rotation = deg_to_rad(y_dir * 90 - 90)
	
	if x_dir != 0:
		self.rotation = deg_to_rad(x_dir * 90)
		
func mine_block():
	if self.rotation_degrees == 0: 		# Facing North
		if world.get_cell_source_id(tile_position + Vector2i(0, -1)) == 0: # Is block minable?
			world.set_cell(tile_position + Vector2i(0, -1), -1) # Mine block to North
	elif self.rotation_degrees == 90: 	# Facing East
		if world.get_cell_source_id(tile_position + Vector2i(1, 0)) == 0: # Is block minable?
			world.set_cell(tile_position + Vector2i(1, 0), -1) # Mine block to East
	elif self.rotation_degrees == -180: 	# Facing South
		if world.get_cell_source_id(tile_position + Vector2i(0, 1)) == 0: # Is block minable?
			world.set_cell(tile_position + Vector2i(0, 1), -1) # Mine block to South
	elif self.rotation_degrees == -90: 	# Facing West
		if world.get_cell_source_id(tile_position + Vector2i(-1, 0)) == 0: # Is block minable?
			world.set_cell(tile_position + Vector2i(-1, 0), -1) # Mine block to West
		
		
func set_world_info(new_world: TileMapLayer) -> void:
	world = new_world
	
func get_movement_input() -> void:
	var new_y_dir = Input.get_axis("Down", "Up")
	if new_y_dir != 0:
		x_dir = 0
		y_dir = new_y_dir
	
	var new_x_dir = Input.get_axis("Left", "Right")
	if new_x_dir != 0:
		y_dir = 0
		x_dir = new_x_dir
	
	
	
	
	
	
	
	
	
