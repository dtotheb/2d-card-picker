extends Node2D
var card = load("res://card.tscn")
var maxHandSize = 5
var HandSize = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	setDeckSizeLabel($deck.get_CardCount())
	setHandSizeLabel(0)
	setDiscardPileSizeLabel(0)
	pass
	
	
func newDeck():
	for myCard in $hand.get_children():
		myCard.queue_free()
	for disCard in $discardPile/discardedCards.get_children():
		disCard.queue_free()
	HandSize = 0
	$deck.generateDeck()
	setDeckSizeLabel($deck.get_CardCount())
	setHandSizeLabel(0)
	setDiscardPileSizeLabel(0)

func drawCard():
	if HandSize < maxHandSize:
		var newCard = $deck.drawCard()
		setDeckSizeLabel($deck.get_CardCount())
		if newCard:
			addCardToHand(newCard)	

func addCardToHand(CardVal):
	var newCard = card.instantiate()
	newCard.cardFace = CardVal
	$hand.add_child(newCard)
	HandSize = $hand.get_child_count()
	setHandSizeLabel(HandSize)
	var cardWidth = Vector2(0.9,0)
	newCard.position = $hand.position * (cardWidth * ( HandSize - 1))
	newCard.CardClicked.connect(playCardToDiscardPile.bind(newCard))
	
func playCardToDiscardPile(PlayedCard):
	PlayedCard.reparent($discardPile/discardedCards)
	PlayedCard.position = $discardPile/discardedCards.position
	PlayedCard.z_index = 2
	PlayedCard.CardClicked.disconnect(playCardToDiscardPile)
	HandSize = $hand.get_children().size()
	setHandSizeLabel(HandSize)
	setDiscardPileSizeLabel($discardPile/discardedCards.get_child_count())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):	
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		drawCard()

func setDeckSizeLabel(count):
	$Control/DeckSizeLabel.text = str(count) + " Cards"

func setDiscardPileSizeLabel(count):
	$Control/DiscardPileSizeLabel.text = str(count) + " Cards"
	
func setHandSizeLabel(count):
	$Control/HandSizeLabel.text = str(count) + "/" + str(maxHandSize) + " Cards in Hand"

func _on_button_pressed():
	newDeck() # Replace with function body.
