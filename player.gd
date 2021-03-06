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
 
const SPEED = 92
const ZOOM_AMT = 0.6	#How much to zoom in
const ZOOM_DUR = 0.7		#How long it takes for it to finish zooming.

var inDialog = false
 
var motion = Vector2()
var diag
var queuedItem
var diagText = [""]
var npcsInRange = 0

onready var ZoomTween = get_node("Camera2D/ZoomTween")
onready var PlayerCamera = get_node("Camera2D")
onready var diagScene = preload("res://dialog.tscn")
onready var anim = get_node("AnimatedSprite")
 
func _physics_process(delta):

	if npcsInRange>0:
		dealWithDialog()
 
	var moveState = NO_MOVEMENT
	if Input.is_action_pressed("ui_up"):
		moveState = MOVE_UP
		anim.play("up")
 
	if Input.is_action_pressed("ui_down"):
		moveState = MOVE_DOWN
		anim.play("down")

	if Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("ui_up"):
			moveState = MOVE_UPLEFT
			anim.play("up_left")
		elif Input.is_action_pressed("ui_down"):
			moveState = MOVE_DOWNLEFT
			anim.play("down_left")
		else:
			moveState = MOVE_LEFT
			anim.play("left")
 
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("ui_up"):
			moveState = MOVE_UPRIGHT
			anim.play("up_right")
		elif Input.is_action_pressed("ui_down"):
			moveState = MOVE_DOWNRIGHT
			anim.play("down_right")
		else:
			moveState = MOVE_RIGHT
			anim.play("right")
			
	if inDialog:
		moveState = NO_MOVEMENT

	match moveState:
		MOVE_UP:
			motion.y = -1
			motion.x = 0
		MOVE_DOWN:
			motion.y = 1
			motion.x = 0
		MOVE_LEFT:
			motion.y = 0
			motion.x = -1
		MOVE_RIGHT:
			motion.y = 0
			motion.x = 1
		MOVE_UPLEFT:
			motion.y = -1
			motion.x = -1
		MOVE_UPRIGHT:
			motion.y = -1
			motion.x = 1
		MOVE_DOWNLEFT:
			motion.y = 1
			motion.x = -1
		MOVE_DOWNRIGHT:
			motion.y = 1
			motion.x = 1
		NO_MOVEMENT:
			motion.y = 0
			motion.x = 0
	
	motion = motion.normalized() * SPEED 

	move_and_slide(motion)
	
func dealWithDialog():
	if Input.is_action_just_pressed("ui_accept"):
		if not inDialog:
			ZoomTween.interpolate_property(PlayerCamera, "zoom", PlayerCamera.zoom, Vector2(ZOOM_AMT, ZOOM_AMT), ZOOM_DUR, Tween.TRANS_SINE, Tween.EASE_OUT)
			ZoomTween.start()
			diag = diagScene.instance()
			#next line, we should set the text to the text associated with
			#whatever npc/thing we are interacting with
			diag.setText(diagText)
			var cl = owner.get_node("CanvasLayer")
			cl.add_child(diag)
			cl.get_node("inventory").showExt()
			cl.get_node("inventory").setCapture(false)
			inDialog = true
		else:
			if diag.textNext():
				ZoomTween.interpolate_property(PlayerCamera, "zoom", PlayerCamera.zoom, Vector2(1, 1), ZOOM_DUR, Tween.TRANS_SINE, Tween.EASE_OUT)
				ZoomTween.start()
				inDialog = false
				var inv = owner.get_node("CanvasLayer/inventory")
				if queuedItem:
					inv.addItem(get_node(queuedItem))
				inv.hideExt()
				inv.setCapture(true)
 
