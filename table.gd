extends Node2D
var card = load("res://card.tscn")
var maxHandSize = 5
var HandSize = 0
var Players = []
var curPlayer = 1



# Called when the node enters the scene tree for the first time.
func _ready():
	Players = {1: $Player1Hand,
				-1: $Player2Hand}
	pass
	
	
func newDeck():
	$Player1Hand.discardHand()
	$Player2Hand.discardHand()
	$discardPile.clearPile()
	$deck.generateDeck()
	$discardPile.setDiscardPileSizeLabel(0)

func drawCard():
		var newCard = $deck.drawCard()
		if newCard:
			addCardToHand(newCard, Players[curPlayer])	
			curPlayer = curPlayer * -1

func addCardToHand(CardVal, TargetHand):
	
	var newCard = card.instantiate()
	newCard.cardFace = CardVal
	
	if TargetHand.AddCard(newCard):
		newCard.CardClicked.connect(playCardToDiscardPile.bind(newCard))
	else:
		$deck.add_child(newCard)
		playCardToDiscardPile(newCard)
	
	
func playCardToDiscardPile(PlayedCard):
	#PlayedCard.CardClicked.disconnect(playCardToDiscardPile)
	var hand = PlayedCard.get_parent().get_parent()
	var Handname = hand.get_name()
	$discardPile.discardCard(PlayedCard)
	if(Handname.contains("Player") and Handname.contains("Hand")):
		hand.CondenseHand()





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_input_event(_viewport, event, _shape_idx):	
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		drawCard()

	
func _on_button_pressed():
	newDeck() # Replace with function body.
