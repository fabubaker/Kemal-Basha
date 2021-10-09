extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var box 
var line
var temp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	move_and_slide(get_local_mouse_position()*100)
	

	
	for i in get_slide_count():
	    var collision = self.get_slide_collision(i)
	    print("Collided with: ", collision.collider.name)

	pass
