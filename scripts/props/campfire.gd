extends Node

@onready var high_light = $Lights/High
@onready var medium_light = $Lights/Medium
@onready var low_light = $Lights/Low
@onready var light_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_high_body_entered(body):
	if body.light_level != null:
		print("helloooososo")
		##body.increase_lightlevel()
	#pass # Replace with function body.


#func _on_high_body_exited(body):
	#if body.light_level:
		#body.light_level -= 1
	#pass # Replace with function body.


func _on_high_area_entered(area):
	if area.light_level != null:
		print("has light level spec")
		##body.increase_lightlevel
