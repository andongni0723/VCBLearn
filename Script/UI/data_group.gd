class_name DataGroup extends Control

@export var vertical: bool :
    set(value):
        vertical = value
        if not container: return
        container.vertical = value
    get():
        return container.vertical

@export var container: FlowContainer
@export var button_prefab : PackedScene
@export var button_icon: Texture2D

var signal_prefix := "open_"
var data_path := ""

func _enter_tree() -> void:
    GlobalSignal.call_refresh_file.connect(_refresh)

func _exit_tree() -> void:
    GlobalSignal.call_refresh_file.disconnect(_refresh)

func _ready() -> void:
    container.vertical = vertical
    _generate_data_button(data_path)


func _generate_data_button(_data_path: String):
    var dir_path: String = DataManager.read_value("file_data_path", "") + "/" + _data_path
    if dir_path.is_empty(): return
    var dir := DirAccess.open(dir_path)
    if dir == null:
        push_error("Can't open file/folder: ", dir_path)
        return

    dir.list_dir_begin()
    var dir_name := dir.get_next()
    while dir_name != "":
        # Skip hide file/folder
        if dir_name.begins_with("."):
            dir_name = dir.get_next()
            continue

        if dir.current_is_dir():
            var b: CustomButton = button_prefab.instantiate()
            container.add_child(b)
            b.initialize(button_icon, dir_name, signal_prefix + dir_name)
            b._on_custom_button_pressed.connect(_on_data_button_pressed)
        dir_name = dir.get_next()
    dir.list_dir_end()


func _delete_all_button():
    for b in container.get_children():
        b.queue_free()


func _refresh():
    _delete_all_button()
    _generate_data_button(data_path)


func _on_data_button_pressed(id: String):
    if not id.begins_with(signal_prefix): return
    var folder_name := id.substr(signal_prefix.length())
    GlobalSignal.call_open_folder_panel.emit(folder_name)
