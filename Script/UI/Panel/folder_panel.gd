class_name FolderPanel extends FullPanel

@export var card_group : CardSetGroup

var folder_path: String
var folder_name: String

@export var folder_name_label: Label

func initialize(_folder_name: String):
    folder_name = _folder_name
    folder_name_label.text = _folder_name
    card_group.initialize(_folder_name)
