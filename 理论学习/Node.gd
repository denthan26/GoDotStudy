extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var aa = Object.new()
	print(aa.get_property_list())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var b = Node2D.new()
	var c = Control.new()
	pass
	
func _enter_tree():
	print("in father")

func _physics_process(delta):
	set_physics_process(false)
	
func _input(event):
	pass
