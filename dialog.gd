extends Node2D

#TODO: have this scene accept a string of text,
# then set the rich text label to that string

const BOXHEIGHT = 24
const POPUPSPEED = 200
const GOAWAYSPEED = 400

onready var topBox = get_node("topBar")
onready var botBox = get_node("botBar")
var boxSet = false #This is true if the top and bottom boxes are finished moving
var die = false #This is true if the player has existed dialog mode and the dialog scene will be deleted
var elTime = 0
var origPosTop
var origPosBot
# Called when the node enters the scene tree for the first time.
func _ready():
	origPosTop = topBox.position
	origPosBot = botBox.position
	print_debug("Ok, text dialog is spawned")
	#Set visible characters to 0


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
		elTime += delta*GOAWAYSPEED
		if elTime == 90:
			queue_free()
	if boxSet:
		# Put in here function that increases the ammount of VisibleCharacters
		# on the text every X ammount of time, until it reaches max length.
		pass

func setText(diagToShow) :
	#TODO: wrap text if its too long and stuff
	#Maybe create an array that holds each dialog screen.
	#Eg: diagToShow[1] = "This is a really long sentence." <- This will be shown on the first screen
	# diagToShow[2] = "This is the last sentence I have to say." <- This will be shown on the second screen.
	var rtl = get_node("topBar/RichTextLabel")
	rtl.text = diagToShow

func textNext():
	#Eventually, this should decide to display the
	# next part of the string, or return true to end
	
	#Eg: Once the first screen is shown, set the text to the second screen, return false
	#If there are no more screens to show, return true.
	print_debug("Meow")
	die = true
	elTime = 0
	return true
	

