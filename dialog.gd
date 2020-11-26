extends Node2D

#TODO: have this scene accept a string of text,
# then set the rich text label to that string

const BOXHEIGHT = 24
const POPUPSPEED = 200

onready var botBox = get_node("Polygon2D")
var boxSet = false
var elTime = 0
var origPos
# Called when the node enters the scene tree for the first time.
func _ready():
	origPos = botBox.position
	print_debug("Ok, text dialog is spawned")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not boxSet:
		if elTime > 90:
			elTime = 90
			boxSet = true
		botBox.position = origPos + Vector2(0, BOXHEIGHT*sin(deg2rad(elTime)))
		elTime += delta*POPUPSPEED

func textNext():
	#Eventually, this should decide to display the
	# next part of the string, or return true to end
	print_debug("Meow")
	return true
