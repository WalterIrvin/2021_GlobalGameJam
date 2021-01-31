extends Area2D

export var pickup_speed = 20
var velocity = Vector2.ZERO
var target = null
export var pickup_acceleration = 70
	
func _physics_process(delta):
	if target:
		velocity = position.direction_to(target.position)
		position += velocity * pickup_speed * delta
		if pickup_speed < 110:
			pickup_speed += pickup_acceleration * delta	
		if position.distance_to(target.position) < 3:
			get_tree().change_scene("res://Objects/GodotCredits.tscn")
		
	
func get_target(player):
	target = player
