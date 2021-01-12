extends Node2D


const SLIDESPEED = 0.5 #the lower the faster

onready var slideTween = get_node("Slide")
onready var ts = get_node("bronze_sprite_hud")
onready var bs = get_node("bronze_sprite_hud/bronze_sprite_inventory")

var extendedHide = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_inventory"):
		if extendedHide:
			slideTween.interpolate_property(ts, "position", ts.position, Vector2(0, bs.texture.get_size().y), SLIDESPEED, Tween.TRANS_SINE, Tween.EASE_OUT)
			slideTween.start()
			extendedHide = false
		else:
			slideTween.interpolate_property(ts, "position", ts.position, Vector2(0, 0), SLIDESPEED, Tween.TRANS_SINE, Tween.EASE_OUT)
			slideTween.start()
			extendedHide = true
