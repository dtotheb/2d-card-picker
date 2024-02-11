extends Node2D

@export var MaxHandSize : int = 5
var cardWidth = Vector2(200,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	setHandSizeLabel(0)
	pass # Replace with function body.


func AddCard(NewCard):
	if $MyCards.get_child_count() < MaxHandSize:
		$MyCards.add_child(NewCard)
		var HandSize = $MyCards.get_child_count()
		setHandSizeLabel(HandSize)
		
		NewCard.position = $MyCards.position + (cardWidth * ( HandSize - 1))
		return true
	else:
		return false

func CondenseHand():
	var curCard = 0
	for Card in $MyCards.get_children():
		Card.position = $MyCards.position + (cardWidth *  curCard )
		curCard += 1
		
	
func setHandSizeLabel(count):
	$HandSizeLabel.text = str(count) + "/" + str(MaxHandSize) + " Cards in Hand"

func discardHand():
	for card in $MyCards.get_children():
		card.queue_free()
	setHandSizeLabel(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
