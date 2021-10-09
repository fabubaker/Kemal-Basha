extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

var collide = false
var hold = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_mouse_button_pressed(1) and !hold:
		hold = true
		
	if !Input.is_mouse_button_pressed(1):
		hold = false
		collide = false
		
	if Input.is_mouse_button_pressed(1) and !collide:
		move_and_slide(get_local_mouse_position()*20)
		
	
	if get_slide_count() > 0 and !collide and hold:
		motion = Vector2()
		var collision = self.get_slide_collision(0)
		if collision.collider.name != "Player":
			collide = true
			
	

	pass