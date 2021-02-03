extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0, 0)
var forward_vec = Vector2(0, 0)
var speed = 25
var lifespan = 2.5
var damage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifespan -= delta
	if lifespan < 0:
		queue_free()
	self.position += self.forward_vec * self.speed


func _on_Bullet_body_entered(body):
	if body.name == "Walls":
		queue_free()
		
	if body.is_in_group("Enemies"):
		body.damage(damage)
		queue_free()
		
	if body.is_in_group("Players"):
		body.damage(damage)
		queue_free()
