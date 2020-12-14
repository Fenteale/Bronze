extends Node2D

onready var gui = preload("res://Inventory.tscn")

var inv

func _ready():
	inv = gui.instance()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


