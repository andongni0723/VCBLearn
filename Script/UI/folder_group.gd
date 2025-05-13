class_name FolderGroup extends DataGroup

func _init() -> void:
    signal_prefix = "open_folder_"
    data_path = ""
    generate_mode = Mode.FOLDER


func _on_data_button_pressed(id: String):
    if not id.begins_with(signal_prefix): return
    var folder_name := id.substr(signal_prefix.length())
    GlobalSignal.call_open_folder_panel.emit(folder_name)

