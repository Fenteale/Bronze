extends Node2D


# Declare member variables here. Examples:
export (Array, String) var npcText = ["Edit Me."]
export var npcType = 0
export(NodePath) var item


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("KinematicBody2D/AnimatedSprite").frame = npcType


func _on_Area2D_body_entered(body):
	print_debug("Body Test")
	if not body.get("diagText")== null:
		body.set("diagText", npcText)
	#if not body.get("queuedItem") == null:
	body.set("queuedItem", item)
	var npcVar = body.get("npcsInRange")
	if not npcVar== null:
		body.set("npcsInRange", npcVar + 1)
	#pass # Replace with function body.


func _on_Area2D_body_exited(body):
	var npcVar = body.get("npcsInRange")
	if not npcVar== null:
		body.set("npcsInRange", npcVar - 1)
	#pass # Replace with function body.
