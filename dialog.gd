extends Node2D

#TODO: have this scene accept a string of text,
# then set the rich text label to that string

const BOXHEIGHT = 24
const POPUPSPEED = 200
const GOAWAYSPEED = 400
const TEXTSCROLLSPEED = 0.04
const CURSORBLINKSPEED = 0.8

onready var topBox = get_node("topBar")
onready var botBox = get_node("botBar")
onready var textObject = get_node("topBar/RichTextLabel")
var boxSet = false #This is true if the top and bottom boxes are finished moving
var die = false #This is true if the player has existed dialog mode and the dialog scene will be deleted
var elTime = 0
var elTimeText = 0
var origPosTop
var origPosBot
var currText = ""

var textArray = []
var textArrayPos = 0
var textCurrPos = 0

var originalLength
# Called when the node enters the scene tree for the first time.
func _ready():
	origPosTop = topBox.position
	origPosBot = botBox.position
	textObject.visible_characters = originalLength
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
		if textCurrPos < originalLength:
			if elTimeText >= TEXTSCROLLSPEED:
				textCurrPos += 1
				textObject.text = currText.substr(0, textCurrPos) + "█"
				elTimeText = 0;
			else:
				elTimeText += delta
		else:
			if elTimeText >= CURSORBLINKSPEED:
				if textObject.visible_characters <= originalLength:
					textObject.visible_characters = textObject.visible_characters + 1
				else:
					textObject.visible_characters = textObject.visible_characters - 1
				elTimeText = 0
			else:
				elTimeText += delta
		pass

func setText(diagToShow) :
	textArray = diagToShow
	var rtl = get_node("topBar/RichTextLabel")
	originalLength = diagToShow[0].length()
	currText = diagToShow[0] + "█"
	rtl.text = "█"
	

func textNext():
	if textArrayPos >= textArray.size() - 1:
		die = true
		elTime = 0
		return true
	else:
		textArrayPos += 1
		originalLength = textArray[textArrayPos].length()
		textObject.visible_characters = originalLength
		currText = textArray[textArrayPos]
		textObject.text = "█"
		elTimeText = 0
		textCurrPos = 0
		return false
	

