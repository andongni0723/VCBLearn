extends Control

@export var vertical: bool :
    set(value):
        vertical = value
        if not container: return
        container.vertical = value
    get():
        return container.vertical

@export var container: FlowContainer
@export var folder_button_prefab : PackedScene
@export var folder_icon: Texture2D

const SIGNAL_PREFIX = "open_folder_"


func _enter_tree() -> void:
    GlobalSignal.call_refresh_file.connect(_refresh_folder)

func _exit_tree() -> void:
    GlobalSignal.call_refresh_file.disconnect(_refresh_folder)

func _ready() -> void:
    _generate_folder_button()


func _generate_folder_button():
    var dir_path: String = DataManager.read_value("file_data_path", "")
    if dir_path.is_empty(): return
    var dir := DirAccess.open(dir_path)
    if dir == null:
        push_error("Can't open folder: ", dir_path)
        return

    dir.list_dir_begin()
    var dir_name := dir.get_next()
    while dir_name != "":
        # Skip other folder
        if dir_name.begins_with("."):
            dir_name = dir.get_next()
            continue

        if dir.current_is_dir():
            var b: CustomButton = folder_button_prefab.instantiate()
            container.add_child(b)
            b.initialize(folder_icon, dir_name, SIGNAL_PREFIX + dir_name)
            b._on_custom_button_pressed.connect(_on_folder_button_pressed)
        dir_name = dir.get_next()
    dir.list_dir_end()


func _delete_all_button():
    for b in container.get_children():
        b.queue_free()


func _refresh_folder():
    _delete_all_button()
    _generate_folder_button()


func _on_folder_button_pressed(id: String):
    if not id.begins_with(SIGNAL_PREFIX): return
    var folder_name := id.substr(SIGNAL_PREFIX.length())
    GlobalSignal.call_open_folder_panel.emit(folder_name)
