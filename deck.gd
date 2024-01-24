extends Node2D

var Cards = []
const cardFaceSuits = ["D","S","H","C"]
const cardFaceVals = ["1", "2", "3", "4", "5", "6", "7","8","9","10","11","12","13"]


# Called when the node enters the scene tree for the first time.
func _ready():
	generateDeck()


func generateDeck(shuffle=true):
	Cards = []
	for suit in cardFaceSuits:
		for val in cardFaceVals:
			var newCard = suit + val
			Cards.append(newCard)
	if shuffle:
		Cards.shuffle()

func drawCard():
	if len(Cards) > 0:
		var topCard = Cards[0]
		Cards.remove_at(0)
		return topCard
	else:
		print("Deck is Empty!")
		return null
	

func on_click():
	var newCard = drawCard()
	print(newCard)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setCards(cardList):
	Cards = cardList

func get_CardCount():
	return len(Cards)

