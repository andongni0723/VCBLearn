extends Control

@export var button: Button
@export var line_edit: LineEdit
@export var file_dialog: FileDialog

@export_category("Setting")
@export var data_save_key: String = ""

var path: String = ""


func _on_button_pressed() -> void:
    file_dialog.visible = true


func _ready() -> void:
    path = DataManager.read_value(data_save_key, "")
    _update_ui(path)


func _on_file_dialog_dir_selected(dir: String) -> void:
    _update_ui(dir)
    DataManager.update_value(data_save_key, dir)


func _update_ui(data: String):
    path = data
    line_edit.text = data
