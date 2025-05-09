extends FloatPanel

@export var line_edit: LineEdit

var new_folder_name : String = ""


func initialize(_r: FloatPanelResource) -> void:
    return


func _on_line_edit_text_changed(new_text:  String) -> void:
    new_folder_name = new_text

func _on_custom_button_pressed(id: String):
    fade_out()
    match id:
        "create_folder":
            if new_folder_name.is_empty(): return
            var folder_path: String = DataManager.read_value("file_data_path", "")
            if folder_path.is_empty(): return
            var folder := DirAccess.open(folder_path)
            folder.make_dir(new_folder_name)
            GlobalSignal.call_refresh_file.emit()
