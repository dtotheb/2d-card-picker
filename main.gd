extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_setButton_pressed():
	$card.cardFace = $Control/cardFaceInput.text
	$card.setCardFace($card.cardFace)
	$card.showCardFace()


func _on_randomButton_pressed():
	$card.setRandomCardFace()
	$card.showCardFace()
	$Control/cardFaceInput.text = $card.cardFace


func _on_flip_button_pressed():
	$card.flipCard()
