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

enum Mode { FOLDER, FILE}
var generate_mode : Mode = Mode.FOLDER

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

        # Check mode and current file type, create button
        if (
            generate_mode == Mode.FOLDER and dir.current_is_dir()
            or generate_mode == Mode.FILE and dir_name.get_extension() == "tres"
        ):
            var b: CustomButton = button_prefab.instantiate()
            container.add_child(b)
            b.initialize(button_icon, titleize_snake(dir_name.get_basename()), signal_prefix + dir_name)
            b._on_custom_button_pressed.connect(_on_data_button_pressed)
        dir_name = dir.get_next()
    dir.list_dir_end()


func titleize_snake(text: String) -> String:
    var parts := text.split("_")
    for i in parts.size():
        parts[i] = parts[i].capitalize()
    return " ".join(parts)


func _delete_all_button():
    for b in container.get_children():
        b.queue_free()


func _refresh():
    _delete_all_button()
    _generate_data_button(data_path)


## When button in panel pressed, call this function.
## Override this function in child class
func _on_data_button_pressed(_id: String):
    assert(false, "%s must override _on_data_button_pressed()" % self)
