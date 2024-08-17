extends Node

@onready var high_light = $Lights/High
@onready var medium_light = $Lights/Medium
@onready var low_light = $Lights/Low
@onready var light_level = 0
@onready var light_occlusion_checker = %OcclusionChecker

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Level started: Campfire")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_high_body_entered(body):
	print("body entered")
	if body.has_method("change_light_level"):
		print("helloooososo")
		##body.increase_lightlevel()
	#pass # Replace with function body.


#func _on_high_body_exited(body):
	#if body.light_level:
		#body.light_level -= 1
	#pass # Replace with function body.


func _on_high_area_entered(area):
	print("area entered")
	if area.has_method("change_light_level"):
		if !light_occlusion_checker.is_colliding():
			area.change_light_level(1)
			print("has light level spec")
			##body.increase_lightlevel
