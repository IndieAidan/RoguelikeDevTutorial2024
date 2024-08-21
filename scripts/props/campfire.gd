extends Node

@onready var high_light = $Lights/High
@onready var medium_light = $Lights/Medium
@onready var low_light = $Lights/Low
@onready var light_level = 0
@onready var light_occlusion_checker = %OcclusionChecker

@onready var TILE_SIZE: int = 32

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
		var target_position =  area.global_position + Vector2(0,0) - self.global_position
		#if area.centre_marker_pos:
			#target_position =  area.centre_marker_pos.global_position - self.global_position
		print("target_position: ", target_position)
		light_occlusion_checker.target_position = target_position
		light_occlusion_checker.force_raycast_update()
		if !light_occlusion_checker.is_colliding():
			print("light hits the target")
			area.change_light_level(1)
			print("has light level spec")
			print("-----------------------------")
			##body.increase_lightlevel


func _on_high_area_exited(area):
	print("area exited")
	if area.has_method("change_light_level"):
		var target_position =  area.global_position + Vector2(0,0) - self.global_position
		#if area.centre_marker_pos:
			#target_position =  area.centre_marker_pos.global_position - self.global_position
		print("target_position: ", target_position)
		light_occlusion_checker.target_position = target_position
		light_occlusion_checker.force_raycast_update()
		if !light_occlusion_checker.is_colliding():
			print("The Target Darkens")
			area.change_light_level(-1)
			print("has light level spec")
			print("-----------------------------")
