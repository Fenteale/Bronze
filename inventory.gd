extends Node2D


const SLIDESPEED = 0.5 #the lower the faster

onready var slideTween = get_node("Slide")
onready var ts = get_node("bronze_sprite_hud")
onready var bs = get_node("bronze_sprite_hud/bronze_sprite_inventory")

var extendedHide = true
var playerExtHide = true
var captureInput = true
var inventory = [null, null, null, null, null, null, null, null, null, null, null] #this is ugly, dun know if there is an easier way to do this

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if captureInput:
		if Input.is_action_just_pressed("ui_inventory"):
			if extendedHide:
				playerExtHide = false
				showExt()
			else:
				playerExtHide = true
				hideExt()
		if Input.is_action_just_pressed("ui_left"):
			pass # handle moving selected left
			#wrap around?
		if Input.is_action_just_pressed("ui_right"):
			pass # handle moving selected right
		if Input.is_action_just_pressed("ui_accept"):
			pass #set the active item as the one selected

func showExt():
	slideTween.interpolate_property(ts, "position", ts.position, Vector2(0, bs.texture.get_size().y), SLIDESPEED, Tween.TRANS_SINE, Tween.EASE_OUT)
	slideTween.start()
	extendedHide = false

func hideExt(force = false):
	if playerExtHide or force: 
		slideTween.interpolate_property(ts, "position", ts.position, Vector2(0, 0), SLIDESPEED, Tween.TRANS_SINE, Tween.EASE_OUT)
		slideTween.start()
		extendedHide = true

func addItem(itemToAdd):
	print_debug("adding ", itemToAdd, " stuff to inventory")
	var indToAdd = 0
	for x in inventory:
		if x == null:
			inventory[indToAdd] = itemToAdd
			break
		indToAdd += 1
	get_node("bronze_sprite_hud/Slot" + String(indToAdd)).texture = itemToAdd.get_node("Sprite").texture
	print_debug(inventory)

func setCapture(cap):
	captureInput = cap
