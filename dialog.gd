extends Node2D

#TODO: have this scene accept a string of text,
# then set the rich text label to that string

const BOXHEIGHT = 24
const POPUPSPEED = 200

onready var topBox = get_node("topBar")
onready var botBox = get_node("botBar")
var boxSet = false
var die = false
var elTime = 0
var origPosTop
var origPosBot
# Called when the node enters the scene tree for the first time.
func _ready():
	origPosTop = topBox.position
	origPosBot = botBox.position
	print_debug("Ok, text dialog is spawned")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not boxSet:
		if elTime > 90:
			elTime = 90
			boxSet = true
		topBox.position = origPosTop + Vector2(0, BOXHEIGHT*sin(deg2rad(elTime)))
		botBox.position = origPosBot - Vector2(0, BOXHEIGHT*sin(deg2rad(elTime)))
		elTime += delta*POPUPSPEED
	if die:
		if elTime > 90:
			elTime = 90
		topBox.position = origPosTop + Vector2(0, BOXHEIGHT*cos(deg2rad(elTime)))
		botBox.position = origPosBot - Vector2(0, BOXHEIGHT*cos(deg2rad(elTime)))
		elTime += delta*POPUPSPEED
		if elTime == 90:
			queue_free()

func setText(diagToShow) :
	#TODO: wrap text if its too long and stuff
	var rtl = get_node("topBar/RichTextLabel")
	rtl.text = diagToShow

func textNext():
	#Eventually, this should decide to display the
	# next part of the string, or return true to end
	print_debug("Meow")
	die = true
	elTime = 0
	return true
