extends Node

const SAVE_PATH = "user://app_data.json"
@onready var add_card_and_folder_resource: Resource = preload("res://Data/Float Panel Data/add_card_and_folder.tres")

var _data: Dictionary = {}
var _default_data := \
{
    "file_data_path" = ""
}

func _enter_tree() -> void:
    GlobalSignal.button_pressed.connect(_on_button_pressed)

func _exit_tree() -> void:
    GlobalSignal.button_pressed.connect(_on_button_pressed)

func _ready() -> void:
    load_data()


func update_value(key: String, value):
    if key.is_empty():
        push_error("update data key is empty")
        return

    if not _default_data.has(key):
        push_error("SET: data not exist key: ", key)
        return

    _data[key] = value
    save_data()


func read_value(key: String, default_value):
    if not _data.has(key):
        push_error("GET: data not exist key: ", key)
        return default_value

    return _data[key]


func save_data():
    var json := JSON.stringify(_data)
    var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    f.store_string(json)
    f.close()
    print("Data:\n", _data)


func load_data():
    if not FileAccess.file_exists(SAVE_PATH):
        _data = _default_data
        return

    var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
    var t := f.get_as_text()
    f.close()

    var parsed = JSON.parse_string(t)
    _data = parsed
    print("Data:\n", _data)


func _on_button_pressed(id: String):
    match id:
        "delete_app_data":
            if not FileAccess.file_exists(SAVE_PATH): return
            var err := DirAccess.remove_absolute(SAVE_PATH)
            print("Deleted App Data" if err == OK else ("Deleted Filed: " + error_string(err)))
            _data = _default_data
