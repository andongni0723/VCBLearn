class_name FolderPanel extends FullPanel

@export var card_group : CardSetGroup

var folder_path: String
var folder_name: String

@export var folder_name_label: Label

func initialize(_folder_name: String):
    folder_name = _folder_name
    folder_name_label.text = _folder_name
    card_group.initialize(_folder_name)


func _on_custom_button_pressed(_id: String):
    match _id:
        "add_card_set":
            GlobalSignal.call_add_float_panel.emit(UIManager.float_panel, DataManager.add_card_set_resource)
        "search":
            print("search")
        "setting":
            GlobalSignal.call_add_float_panel.emit(UIManager.float_panel, DataManager.folder_edit_resource)