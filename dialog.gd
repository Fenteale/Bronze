extends Node2D

#const BOXHEIGHT = 24 #depricated, just change the text box's polygon
const POPUPSPEED = 0.5
const GOAWAYSPEED = 400
const TEXTSCROLLSPEED = 0.04
const CURSORBLINKSPEED = 0.8


onready var topBox = get_node("RichTextLabel")
onready var st = get_node("Slide")

onready var BOXHEIGHT = topBox.rect_size.y
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
	origPosTop = topBox.rect_position
	#textObject.visible_characters = originalLength
	print_debug("Ok, text dialog is spawned")
	#Set visible characters to 0
	st.interpolate_property(topBox, "rect_position", topBox.rect_position, Vector2(0, 0), POPUPSPEED, Tween.TRANS_SINE, Tween.EASE_OUT)
	st.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boxSet:
		if textCurrPos < originalLength:
			if elTimeText >= TEXTSCROLLSPEED:
				textCurrPos += 1
				topBox.text = currText.substr(0, textCurrPos) + "█"
				elTimeText = 0;
			else:
				elTimeText += delta
		else:
			if elTimeText >= CURSORBLINKSPEED:
				if topBox.visible_characters <= originalLength:
					topBox.visible_characters = topBox.visible_characters + 1
				else:
					topBox.visible_characters = topBox.visible_characters - 1
				elTimeText = 0
			else:
				elTimeText += delta
		pass

func setText(diagToShow) :
	textArray = diagToShow
	var rtl = get_node("RichTextLabel")
	originalLength = diagToShow[0].length()
	rtl.visible_characters = originalLength
	currText = diagToShow[0] + "█"
	rtl.text = "█"
	

func textNext():
	if textArrayPos >= textArray.size() - 1:
		die = true
		elTime = 0
		st.interpolate_property(topBox, "rect_position", topBox.rect_position, Vector2(0, -BOXHEIGHT), POPUPSPEED, Tween.TRANS_SINE, Tween.EASE_OUT)
		st.start()
		return true
	else:
		textArrayPos += 1
		originalLength = textArray[textArrayPos].length()
		topBox.visible_characters = originalLength
		currText = textArray[textArrayPos]
		topBox.text = "█"
		elTimeText = 0
		textCurrPos = 0
		return false
	


func _on_Slide_tween_completed(object, key): #lazy that we aren't checking to make sure that its the tween we want
	boxSet = true
	if die:
		print_debug("I guess... It's time to die.")
		queue_free()
