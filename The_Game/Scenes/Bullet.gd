extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 10
var direction = Vector2(0, 1)
var lifespan = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifespan -= delta
	if lifespan < 0:
		queue_free()
	self.position += direction * speed
