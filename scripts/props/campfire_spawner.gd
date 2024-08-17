extends Node2D

@onready var campfire_scene: PackedScene = preload("res://scenes/props/campfire.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var campfire_instance = campfire_scene.instantiate()
	add_child(campfire_instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
