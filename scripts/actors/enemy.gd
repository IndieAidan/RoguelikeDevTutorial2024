extends Node

#@onready var tile_map = preload("res://scenes/tile_map.tscn")
@onready var tile_map = $"../TileMap"
@onready var player = $"../Player"

var tile_size = 24
var astar_grid: AStarGrid2D
var is_moving: bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(tile_size,tile_size)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER # makes it so enemies cannot go diagonally, will probably change this
	astar_grid.update()
	
	var region_size = astar_grid.region.size
	var region_position = astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			var tile_position = Vector2i(
				x + region_position.x,
				y + region_position.y
			)
			
			var tile_data = tile_map.get_cell_tile_data(0, tile_position)
			
			if tile_data == null or not tile_data.get_custom_data("walkable"):
				astar_grid.set_point_solid(tile_position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		return
	
	move()


func move():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var occupied_positions = []
	
	for enemy in enemies:
		if enemy == self:
			continue
		
		occupied_positions.append(tile_map.local_to_map(enemy.global_position))
	
	#TODO add occupied positions for other things, such as temporary blockages
	for occupied_position in occupied_positions:
		astar_grid.set_point_solid(occupied_position)
	
	var path = astar_grid.get_id_path(
		tile_map.local_to_map(self.global_position),
		tile_map.local_to_map(player.global_position)
	)
	
	for occupied_position in occupied_positions: 
		astar_grid.set_point_solid(occupied_position, false)
	
	path.pop_front()
	
	if path.size() == 1:
		print("I have arrived at the target")
	
	if path.is_empty():
		print("cannot find path")
		return
	
	var original_position = Vector2(self.global_position)
	
	self.global_position = tile_map.map_to_local(path[0])
	$AnimatedSprite2D.global_position = original_position
	
	is_moving = true
	await get_tree().create_timer(1.0).timeout # wait for 1 second


func _physics_process(_delta):
	if is_moving:
		#await get_tree().create_timer(1.0).timeout # wait for 1 second
#		$AnimatedSprite2D.global_position = $AnimatedSprite2D.global_position.move_toward(self.global_positon, 1)
		
#		if $AnimatedSprite2D.global_position != self.global_position:
#			return
		
		is_moving = false









