extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var hook
var distance
var hooked 
var moved = false
var tem_pos
var w_pressed = false

const JUMP_HEIGHT = -350 # -350 is normal, change to -600 for god mode
const RUN_SPEED = 200 # 200 is normal, change to -500 for god mode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	update()
	if !hooked:
		motion.y += 20
		
	# Setup death on lava contact
	var lava_tilemap = get_parent().get_node("Lava")
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.collider.name)
		if collision.collider.name == "Lava":
			get_tree().reload_current_scene()
		
	hook = get_node("../Hook")
	# controls for movement
	if Input.is_key_pressed(KEY_A):
		motion.x = -RUN_SPEED
	elif Input.is_key_pressed(KEY_D):
		motion.x = RUN_SPEED
	elif Input.is_key_pressed(KEY_S):
		motion.y = 100
	else:
		motion.x = 0
		#motion.y = 20
		
	if is_on_floor():
		if Input.is_key_pressed(KEY_W):
			motion.y = JUMP_HEIGHT
			
	if Input.is_key_pressed(KEY_W) and hooked:
		motion.y = -200
		w_pressed = true
		
	if !Input.is_key_pressed(KEY_W):
		w_pressed = false
	

	var shape = hook.get_node("CollisionShape2D")
	shape.set_disabled(true)
	
	if Input.is_mouse_button_pressed(1):
		shape.set_disabled(false)
		
	if !Input.is_mouse_button_pressed(1):
		hook.position = position
		hooked = false
		motion.y += 20
		w_pressed = false
	
	if hooked:
		#print ("x: ", position.distance_to(hook.position))
		#print ("hook: ", distance)
		
		if !w_pressed and (position.y < tem_pos.y - 30 or position.y > tem_pos.y + 30):
			if position.x < hook.position.x:
				motion.y = -150
			if position.x > hook.position.x:
				motion.y = -150
			if position.distance_to(hook.position) < distance:
				motion.y = 150
			else:
				motion.y = -150
	
	if (hook.get_slide_count() and Input.is_mouse_button_pressed(1)):
		hooked = true
		if !moved:
			distance = position.distance_to(hook.position) - 50
			motion.y = -150
			tem_pos = position
		
		moved = true
	else:
		hooked = false
		moved = false
		

	motion = move_and_slide(motion, UP)
	update()
	return
	
func _draw():
	hook = get_node("../Hook")
	if Input.is_mouse_button_pressed(1):
		draw_line(Vector2(), hook.position - position, Color(255, 0, 0, 1), 10)
	else:
		draw_line(Vector2(), hook.position - position, Color(255, 0, 0, 0), 1)