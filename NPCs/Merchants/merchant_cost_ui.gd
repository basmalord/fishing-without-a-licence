extends Control

@onready var cost_label = $CostLabel
@onready var my_merchant = get_parent()
var cost_label_text: String

func _ready():
	display_cost()

func display_cost():
	cost_label_text = str(my_merchant.cost)
	cost_label.text = cost_label_text
