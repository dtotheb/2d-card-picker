extends Node2D
@export var cardFace: String = ""
@export var faceDown = false

signal CardClicked

var cardFaceSuits = ["D","S","H","C"]
var cardFaceVals = ["1", "2", "3", "4", "5", "6", "7","8","9","10","11","12","13"]

# Called when the node enters the scene tree for the first time.
func _ready():
	if cardFace:
		setCardFace(cardFace)

func flipCard():
	if faceDown:
		faceDown = false
		showCardFace()
	else:
		faceDown = true
		showCardBack()

func setRandomCardFace():
	var suit = cardFaceSuits[ randi() % cardFaceSuits.size() ]
	var val = cardFaceVals[ randi() % cardFaceVals.size() ]
	setCardFace(suit + val)
	cardFace = suit + val
	
func showCardBack(back=0):
	$AnimatedSprite2D.play("card_back",0)
	$AnimatedSprite2D.frame = back
	

func showCardFace():
	var suit = cardFace.substr(0,1)
	if suit == "C":
		$AnimatedSprite2D.play("clubs",0)
	elif suit == "S":
		$AnimatedSprite2D.play("spades",0)
	elif suit == "H":
		$AnimatedSprite2D.play("hearts",0)
	elif suit == "D":
		$AnimatedSprite2D.play("diamonds",0)
		
	var cardFrame = int(cardFace.substr(1)) - 1
	$AnimatedSprite2D.frame = cardFrame

func setCardFace(newCardFace):
	cardFace = newCardFace


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if faceDown:
		showCardBack()
	else:
		showCardFace()





func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		emit_signal("CardClicked")
