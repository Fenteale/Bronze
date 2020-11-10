extends KinematicBody2D


enum {
	NO_MOVEMENT,
	MOVE_LEFT,
	MOVE_UPLEFT,
	MOVE_UP,
	MOVE_UPRIGHT,
	MOVE_RIGHT,
	MOVE_DOWNRIGHT,
	MOVE_DOWN,
	MOVE_DOWNLEFT
}
 
const SPEED = 48
const SPEEDDIAG = sqrt((SPEED*SPEED)/2)
 
var motion = Vector2()
 
func _physics_process(delta):
 
	var moveState = NO_MOVEMENT
	if Input.is_action_pressed("ui_up"):
		moveState = MOVE_UP
 
	if Input.is_action_pressed("ui_down"):
		moveState = MOVE_DOWN
	if Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("ui_up"):
			moveState = MOVE_UPLEFT
		elif Input.is_action_pressed("ui_down"):
			moveState = MOVE_DOWNLEFT
		else:
			moveState = MOVE_LEFT
 
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("ui_up"):
			moveState = MOVE_UPRIGHT
		elif Input.is_action_pressed("ui_down"):
			moveState = MOVE_DOWNRIGHT
		else:
			moveState = MOVE_RIGHT

	match moveState:
		MOVE_UP:
			motion.y = -SPEED
			motion.x = 0
		MOVE_DOWN:
			motion.y = SPEED
			motion.x = 0
		MOVE_LEFT:
			motion.y = 0
			motion.x = -SPEED
		MOVE_RIGHT:
			motion.y = 0
			motion.x = SPEED
		MOVE_UPLEFT:
			motion.y = -SPEEDDIAG
			motion.x = -SPEEDDIAG
		MOVE_UPRIGHT:
			motion.y = -SPEEDDIAG
			motion.x = SPEEDDIAG
		MOVE_DOWNLEFT:
			motion.y = SPEEDDIAG
			motion.x = -SPEEDDIAG
		MOVE_DOWNRIGHT:
			motion.y = SPEEDDIAG
			motion.x = SPEEDDIAG
		NO_MOVEMENT:
			motion.y = 0
			motion.x = 0
 
	move_and_slide(motion)
 
