extends PanelContainer
class_name CardSortPanel

@onready var card_list: ReorderableContainer = %CardList

func get_card_list() -> ReorderableContainer:
	return card_list
