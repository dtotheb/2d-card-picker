extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setDiscardPileSizeLabel(count):
	$DiscardPileSizeLabel.text = str(count) + " Cards"

func discardCard(PlayedCard):
	PlayedCard.reparent($Cards)
	PlayedCard.position = $Cards.position
	PlayedCard.z_index = 2
	var CardCount = $Cards.get_child_count()
	setDiscardPileSizeLabel(CardCount)
	
func clearPile():
	for card in $Cards.get_children():
		card.queue_free()
