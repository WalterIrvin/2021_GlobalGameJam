extends KinematicBody2D

export var speed = 50
export var health = 10
export (PackedScene) var Soul
var velocity = Vector2()
var chase = false
var target = null
var alive = true
var death_delay = 3
var death_timer = death_delay
	
func _ready():
	rotation = rand_range(0, 2*PI)
	
	
func _physics_process(delta):
	if chase == false:
		velocity = transform.x * speed
	else:
		if target:
			velocity = position.direction_to(target.position) * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.name == "Player":
			if target.damage_timer <= 0:
				target.health -= 1
				target.damage_timer = target.damage_delay
		else:
			velocity = velocity.bounce(collision.normal).rotated(rand_range(-PI/4, PI/4))
	rotation = velocity.angle()
	if health <= 0:
		if alive == true:
			$Death.play()
			var s = Soul.instance()
			get_parent().add_child(s)
			s.position = position
		alive = false
		death_timer -= delta
		hide()
		$CollisionShape2D.disabled = true
		if death_timer <= 0:
			queue_free()


func _on_Aggro_Area_body_entered(body):
	if body.is_in_group("player"):
		chase = true
		target = body
