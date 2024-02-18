# PopupText.gd

extends Popup

@onready var label = $Label

func set_popup_text(text):
	label.text = text
