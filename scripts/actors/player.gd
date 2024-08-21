extends Area2D

@onready var TILE_SIZE = 32
@onready var ray = $RayCast2D
@onready var moving = false
@onready var turn_length = 0.1 # time each turn takes in seconds
@onready var light_level = 0

@onready var centre_marker_pos = %CentreMarker.global_position

# --- Stats --- 
@export var strength: int = 10
@export var speed: int = 10
@export var dexterity: int = 10
@export var intelligence: int = 10
@export var endurance: int = 10


# Initial grid movement taken from my initial roguelike project, which was based on a youtube video (I forget which)
# and from KidsCanCode https://kidscancode.org/godot_recipes/4.x/2d/grid_movement/
var inputs = {"move_right": Vector2.RIGHT,
			"move_left": Vector2.LEFT,
			"move_up": Vector2.UP,
			"move_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * TILE_SIZE)
	position += Vector2.ONE * TILE_SIZE/2
	$AnimatedSprite2D.flip_h = true
	print("player loaded")

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

#func move(dir):
#	position += inputs[dir] * tile_size
#	move_and_slide()

func move(dir):
	ray.target_position = inputs[dir] * TILE_SIZE
	#ray.target_position = inputs[dir] * 16
	ray.force_raycast_update()
	if dir == "move_right":
		$AnimatedSprite2D.flip_h = true
	elif dir == "move_left":
		$AnimatedSprite2D.flip_h = false
	if !ray.is_colliding():
		print(dir)
		print("current light level: ", light_level)
		$AnimatedSprite2D.play("moving")
		var tween = create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * TILE_SIZE, turn_length).set_trans(Tween.TRANS_SINE)
		#await get_tree().create_timer(turn_length).timeout
		moving = true
		await tween.finished
		move_false() # this was in the youtube video, but not KidsCanCode. Could just switch moving to false here, without a new function. 
		#tween.tween_callback(move_false)
		#position += inputs[dir] * TILE_SIZE # moves to tile instantly
	else:
		pass

func move_false():
	moving = false
	$AnimatedSprite2D.play("idle")

func change_light_level(amount):
	light_level += amount
	print("Player Light Level is ", light_level)

func increase_lightlevel():
	light_level += 1

func decrease_lightlevel():
	light_level -= 1
